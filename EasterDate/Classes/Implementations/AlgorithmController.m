/**
 @file AlgorithmController.m
 @brief Classe per la gestione della schermata per la pagina Web dell'algoritmo.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "AlgorithmController.h"
#import "Utilities.h"
#import "Constants.h"
#import "Colors.h"
#import "Macros.h"

@implementation AlgorithmController

@synthesize algorithmContent;

/**
 @brief Metodo di sistema invocato per inizializzazione del layout.
 @param nibNameOrNil Nome del file di interfaccia di riferimento.
 @param nibBundleOrNil Bundle di riferimento.
 @return Istanza inizializzata.
 */
- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil
{
    //Invocato il metodo della superclasse.
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    
    //Inizializzazione personalizzata.
    if (self)
    {
        //Inizializza il titolo della barra di navigazione.
        self.navigationItem.title = NSLocalizedString(@"AlgorithmTitle", @"AlgorithmTitle");
    }
    
    //Ritorna l'istanza inizializzata.
    return self;
}

/**
 @brief Metodo di sistema invocato al caricamento del layout.
 */
- (void) viewDidLoad
{
    //Invocato il metodo della superclasse.
    [super viewDidLoad];
    
    //Impedisce a specifici controlli di finire al di sotto della Tab Bar.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Visualizza la barra di navigazione.
    [self.navigationController.navigationBar setHidden: NO];
    
    //Personalizza un pulsante per il ritorno a questa interfaccia.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @" " style: UIBarButtonItemStylePlain target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //Disattiva il ritorno alla schermata precedente usando la gesture di swipe verso sinistra.
    [self.navigationController.interactivePopGestureRecognizer setEnabled: NO];
    
    //Evita l'utilizzo di una Navigation Bar traslucida.
    [self.navigationController.navigationBar setTranslucent: NO];
    
    //Se possibile evita l'uso di una Tab Bar traslucida.
    [self.tabBarController.tabBar setTranslucent: NO];
}

/**
 @brief Metodo di sistema invocato alla comparsa del layout.
 @param animated Flag per la gestione dell'animazione di comparsa.
 */
- (void) viewWillAppear: (BOOL) animated
{
    //Invocato il metodo della superclasse.
    [super viewWillAppear: animated];
    
    //Registra la WebView principale.
    algorithmContent.delegate = self;
    
    //Lancia e visualizza l'indicatore di progresso.
    if ([viewOverlay superview]) [viewOverlay removeFromSuperview];
    if ([serverProgress superview]) [serverProgress removeFromSuperview];
    [self initSpinner];
    [self.view addSubview: viewOverlay];
    [self.view addSubview: serverProgress];
    [serverProgress startAnimating];
    
    //Personalizzazione Back Button (iPad).
    if (IS_IPAD)
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target: nil action: nil];
        negativeSpacer.width = -16.0f;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 44.0f, self.navigationController.navigationBar.frame.size.height)];
        [backButton setImage: [UIImage imageNamed: @"back"]  forState: UIControlStateNormal];
        [backButton addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView: backButton], nil];
    }
    
    //Configura l'aspetto della WebView principale.
    [algorithmContent.scrollView setShowsVerticalScrollIndicator: NO];
    [algorithmContent.scrollView setShowsHorizontalScrollIndicator: NO];
    [algorithmContent.scrollView setDecelerationRate: UIScrollViewDecelerationRateNormal];
}

/**
 @brief Metodo di sistema invocato alla comparsa del layout.
 @param animated Flag per la gestione dell'animazione di comparsa.
 */
- (void) viewDidAppear: (BOOL) animated
{
    //Invocato il metodo della superclasse.
    [super viewDidAppear: animated];
    
    //Verifica la presenza di connessione di Rete.
    if ([Utilities isOnline])
    {
        //Visualizzazione asincrona della pagina Web di riferimento.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL: [NSURL URLWithString: NSLocalizedString(@"WikipediaPage", @"WikipediaPage")]];
            [algorithmContent loadRequest: urlRequest];
        });
    }
    else
    {
        //Ferma e nasconde l'indicatore di progresso.
        if ([viewOverlay superview]) [viewOverlay removeFromSuperview];
        [serverProgress stopAnimating];
        if ([serverProgress superview]) [serverProgress removeFromSuperview];
        
        //Notifica l'assenza di connessione di Rete.
        [Utilities showToast: @"NoNetworkAlert"];
    }
}

/**
 @brief Metodo per il ritorno alla schermata precedente.
 */
- (void) goBack
{
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self.navigationController popViewControllerAnimated: YES];
    });
}

/**
 @brief Metodo di sistema per contesti di sovrautilizzo di memoria.
 */
- (void) didReceiveMemoryWarning
{
    //Invocato il metodo della superclasse.
    [super didReceiveMemoryWarning];
}

/**
 @brief Metodo di sistema per la gestione di variazioni nell'orientazione del dispositivo.
 */
- (void) viewWillTransitionToSize: (CGSize) size withTransitionCoordinator: (id <UIViewControllerTransitionCoordinator>) coordinator
{
    //Invocato il metodo della superclasse.
    [super viewWillTransitionToSize: size withTransitionCoordinator: coordinator];
    
    //Gestisce il cambio di orientazione.
    [coordinator animateAlongsideTransition: ^(id <UIViewControllerTransitionCoordinatorContext> context)
     {} completion: ^(id <UIViewControllerTransitionCoordinatorContext> context)
     {
         //Aggiorna la visualizzazione dell'indicatore di progresso, se animato.
         if ([viewOverlay superview] && [serverProgress superview])
         {
             [viewOverlay removeFromSuperview];
             [serverProgress removeFromSuperview];
             [self initSpinner];
             [self.view addSubview: viewOverlay];
             [self.view addSubview: serverProgress];
             [serverProgress startAnimating];
         }
     }];
}

/**
 @brief Metodo per inizializzazione degli indicatori di comunicazione con il server.
 */
- (void) initSpinner
{
    serverProgress = [[DRPLoadingSpinner alloc] initWithFrame: CGRectMake(SCREEN_WIDTH / 2 - 20, SCREEN_HEIGHT / 2 - 90, SPINNER_SIZE, SPINNER_SIZE)];
    serverProgress.rotationCycleDuration = 1.0f;
    serverProgress.drawCycleDuration = 0.1f;
    serverProgress.lineWidth = 4.0f;
    serverProgress.maximumArcLength = M_PI + M_PI_2;
    serverProgress.minimumArcLength = M_PI;
    serverProgress.colorSequence = @[MAIN_COLOR];
    viewOverlay = [Utilities customOverlay: NO];
}

/**
 @brief Metodo gestore del termine del caricamento del contenuto della WebView.
 @param webView WebView di riferimento.
 */
- (void) webViewDidFinishLoad: (UIWebView *) webView
{
    //Ferma e nasconde l'indicatore di progresso.
    if ([viewOverlay superview]) [viewOverlay removeFromSuperview];
    [serverProgress stopAnimating];
    if ([serverProgress superview]) [serverProgress removeFromSuperview];
}

/**
 @brief Metodo gestore di errori nel caricamento del contenuto della WebView.
 @param webView WebView di riferimento.
 @param error Eventuale errore nel caricamento della WebView.
 */
- (void) webView: (UIWebView *) webView didFailLoadWithError: (NSError *) error
{
    //Ferma e nasconde l'indicatore di progresso.
    if ([viewOverlay superview]) [viewOverlay removeFromSuperview];
    [serverProgress stopAnimating];
    if ([serverProgress superview]) [serverProgress removeFromSuperview];
    
    //Visualizza una notifica di errore.
    [Utilities showToast: @"NoSupportAlert"];
}

/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate
{
    return IS_IPAD;
}

@end
