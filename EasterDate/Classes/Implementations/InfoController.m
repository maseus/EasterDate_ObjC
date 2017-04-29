/**
 @file InfoController.m
 @brief Classe per la gestione della schermata informativa.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "InfoController.h"
#import "AlgorithmController.h"
#import "Utilities.h"
#import "Colors.h"
#import "Constants.h"
#import "Xib.h"

@implementation InfoController

@synthesize scrollView;
@synthesize infoTitle;
@synthesize versionLabel;
@synthesize versionCode;
@synthesize authorLabel;
@synthesize authorInfo;
@synthesize badgeView;
@synthesize facebookBadge;
@synthesize linkedinBadge;
@synthesize githubBadge;
@synthesize skypeBadge;
@synthesize mailBadge;
@synthesize algorithmLink;

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
        self.navigationItem.title = NSLocalizedString(@"AppName", @"AppName");
        
        //Personalizza l'icona della relativa Tab.
        self.title = nil;
        self.tabBarItem.image = [UIImage imageNamed: @"info"];
        
        //Ricolloca l'icona nella Tab Bar.
        self.tabBarItem.imageInsets = TAB_INSETS;
        
        //Regola l'ampiezza delle Tab.
        [[UITabBar appearance] setItemWidth: ([Utilities isPortrait] ? SCREEN_WIDTH : SCREEN_HEIGHT) / TABS];
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
    
    //Adatta le dimensioni della ScrollView alla View principale.
    [scrollView setFrame: self.view.frame];
    
    //Colloca la ScrollView nella View principale.
    [self.view addSubview: scrollView];
    
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
    
    //Inizializza i componenti del layout.
    [self initLayout];
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
         //Regola l'altezza della ScrollView principale.
         [Utilities adjustInset: scrollView height: [self scrollHeight]];
     }];
}

/**
 @brief Metodo per inizializzazione dei componenti del layout.
 */
- (void) initLayout
{
    //Valorizza i testi principali.
    infoTitle.text = NSLocalizedString(@"InfoDesc", @"InfoDesc");
    versionLabel.text = NSLocalizedString(@"VersionTitle", @"VersionTitle");
    versionCode.text = NSLocalizedString(@"VersionNumber", @"VersionNumber");
    authorLabel.text = NSLocalizedString(@"AuthorTitle", @"AuthorTitle");
    authorInfo.text = NSLocalizedString(@"AuthorText", @"AuthorText");
    
    //Inizializza il testo del link alla pagina Wikipedia dell'algoritmo.
    [algorithmLink setTitle: NSLocalizedString(@"AlgorithmLink", "AlgorithmLink") forState: UIControlStateNormal];
    
    //Regola l'altezza della ScrollView principale.
    [Utilities adjustInset: scrollView height: [self scrollHeight]];
}

/**
 @brief Metodo per il calcolo dell'altezza del contenuto della ScrollView principale.
 @return Altezza per il contenimento dei controlli principali.
 */
- (CGFloat) scrollHeight
{
    CGFloat scrollHeight = 0.0f;
    scrollHeight = scrollHeight + infoTitle.frame.size.height;
    scrollHeight = scrollHeight + versionLabel.frame.size.height;
    scrollHeight = scrollHeight + versionCode.frame.size.height;
    scrollHeight = scrollHeight + authorLabel.frame.size.height;
    scrollHeight = scrollHeight + authorInfo.frame.size.height;
    scrollHeight = scrollHeight + badgeView.frame.size.height;
    scrollHeight = scrollHeight + algorithmLink.frame.size.height;
    
    if (IS_IPAD && [Utilities isLandscape]) return scrollHeight + 400.0f;
    return scrollHeight + 200.0f;
}

/**
 @brief Metodo per l'invio di una e-mail all'indirizzo indicato.
 @param mailAddress Indirizzo e-mail del destinatario.
 */
- (void) sendMail: (NSString *) mailAddress
{
    //Verifica la disponibilità del servizio.
    if ([MFMailComposeViewController canSendMail])
    {
        //Inizializza il gestore del servizio.
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        //Indica il destinatario richiesto.
        [mailComposer setToRecipients: @[mailAddress]];
        
        //Visualizza il sistema per la composizione dell'e-mail.
        [self presentViewController: mailComposer animated: YES completion: nil];
    }
    //Notifica la mancanza del supporto richiesto.
    else [Utilities showToast: @"NoSupportAlert"];
}

/**
 @brief Metodo gestore dell'esito dell'invio dell'e-mail.
 @param controller ViewController gestore della composizione dell'e-mail.
 @param result Risultato dell'operazione.
 @param error Eventuale errore nella gestione dell'operazione.
 */
- (void) mailComposeController: (MFMailComposeViewController *) controller didFinishWithResult: (MFMailComposeResult) result error: (NSError *) error
{
    //Verifica il risultato ottenuto.
    switch (result)
    {
        //Invio annullato.
        case MFMailComposeResultCancelled:
            
            [Utilities showToast: @"MailCancelledAlert"];
            break;
            
        //Mail salvata tra le bozze.
        case MFMailComposeResultSaved:
            
            [Utilities showToast: @"MailSavedAlert"];
            break;
            
        //Mail inviata correttamente.
        case MFMailComposeResultSent:
            
            [Utilities showToast: @"MailSentAlert"];
            break;
            
        //Errore nell'invio dell'e-mail.
        case MFMailComposeResultFailed:
            
            [Utilities showToast: @"MailErrorAlert"];
            break;
            
        default:
            
            [Utilities showToast: @"NoSupportAlert"];
            break;
    }
    
    //Chiude il sistema per la gestione dell'e-mail.
    [self dismissViewControllerAnimated: YES completion: nil];
}

/**
 @brief Metodo di interazione con i pulsanti per i profili dell'autore.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) handleBadge: (id) sender
{
    //Interazione con il pulsante per il profilo Facebook.
    if ([sender isEqual: facebookBadge])
    {
        //Effetto di animazione grafica.
        facebookBadge.alpha = 0.4f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            facebookBadge.alpha = 1.0f;
        });
        
        //Visualizza il profilo Facebook dell'autore.
        if ([Utilities isOnline]) [Utilities openUrl: FACEBOOK_URL];
        //Notifica l'assenza di connessione di Rete.
        else [Utilities showToast: @"NoNetworkAlert"];
    }
    //Interazione con il pulsante per il profilo LinkedIn.
    else if ([sender isEqual: linkedinBadge])
    {
        //Effetto di animazione grafica.
        linkedinBadge.alpha = 0.4f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            linkedinBadge.alpha = 1.0f;
        });
        
        //Visualizza il profilo LinkedIn dell'autore.
        if ([Utilities isOnline]) [Utilities openUrl: LINKEDIN_URL];
        //Notifica l'assenza di connessione di Rete.
        else [Utilities showToast: @"NoNetworkAlert"];
    }
    //Interazione con il pulsante per il profilo GitHub.
    else if ([sender isEqual: githubBadge])
    {
        //Effetto di animazione grafica.
        githubBadge.alpha = 0.4f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            githubBadge.alpha = 1.0f;
        });
        
        //Visualizza il profilo GitHub dell'autore.
        if ([Utilities isOnline]) [Utilities openUrl: GITHUB_URL];
        //Notifica l'assenza di connessione di Rete.
        else [Utilities showToast: @"NoNetworkAlert"];
    }
    //Interazione con il pulsante per il profilo Skype.
    else if ([sender isEqual: skypeBadge])
    {
        //Effetto di animazione grafica.
        skypeBadge.alpha = 0.4f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            skypeBadge.alpha = 1.0f;
        });
        
        //Contatta il profilo Skype dell'autore.
        if ([Utilities isOnline]) [Utilities openSkype: SKYPE_NAME];
        //Notifica l'assenza di connessione di Rete.
        else [Utilities showToast: @"NoNetworkAlert"];
    }
    //Interazione con il pulsante per il contatto e-mail.
    else if ([sender isEqual: mailBadge])
    {
        //Effetto di animazione grafica.
        mailBadge.alpha = 0.4f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            mailBadge.alpha = 1.0f;
        });
        
        //Predispone l'invio di un'e-mail all'autore.
        if ([Utilities isOnline]) [self sendMail: MAIL_ADDRESS];
        //Notifica l'assenza di connessione di Rete.
        else [Utilities showToast: @"NoNetworkAlert"];
    }
}

/**
 @brief Metodo di interazione con il link alla pagina Wikipedia dell'algoritmo.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) showWebPage: (id) sender
{
    //Effetto di animazione grafica.
    algorithmLink.alpha = 0.4f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        algorithmLink.alpha = 1.0f;
    });
    
    //Verifica la presenza di connessione di Rete.
    if ([Utilities isOnline])
    {
        //Lancia la visualizzazione della pagina Wikipedia dell'algoritmo.
        AlgorithmController *algorithm = [[AlgorithmController alloc] initWithNibName: ALGORITHM_XIB bundle: nil];
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [self.navigationController pushViewController: algorithm animated: YES];
        });
    }
    //Notifica l'assenza di connessione di Rete.
    else [Utilities showToast: @"NoNetworkAlert"];
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
