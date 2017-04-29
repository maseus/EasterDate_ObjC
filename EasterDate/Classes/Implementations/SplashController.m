/**
 @file SplashController.m
 @brief Classe per la gestione della schermata di lancio.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "SplashController.h"
#import "MainController.h"
#import "InfoController.h"
#import "Utilities.h"
#import "Constants.h"
#import "Xib.h"

@implementation SplashController

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
    {}
    
    //Ritorna l'istanza inizializzata.
    return self;
}

/**
 @brief Metodo di sistema invocato al caricamento del layout.
 */
- (void) viewDidLoad
{
    //Invocato il metodo della superc lasse.
    [super viewDidLoad];
    
    //Disattiva il ritorno alla schermata precedente usando la gesture di swipe verso sinistra.
    [self.navigationController.interactivePopGestureRecognizer setEnabled: NO];
    
    //Nasconde la barra di navigazione.
    [self.navigationController.navigationBar setHidden: YES];
    
    //Lancia l'applicazione principale dopo ritardo specifico.
    [self performSelector: @selector(startMain) withObject: nil afterDelay: REFRESH_DELAY];
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
 @brief Metodo per il lancio dell'applicazione principale.
 */
- (void) startMain
{
    //Inizializza le schermate principali dell'applicazione.
    MainController *main = [[MainController alloc] initWithNibName: MAIN_XIB bundle: nil];
    InfoController *info = [[InfoController alloc] initWithNibName: INFO_XIB bundle: nil];
    main.extendedLayoutIncludesOpaqueBars = YES;
    info.extendedLayoutIncludesOpaqueBars = YES;
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController: main];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController: info];
    
    //Inserisce le schermate nel TabBarController principale.
    [Utilities appDelegate].tabBarController = [[UITabBarController alloc] init];
    [Utilities appDelegate].tabBarController.viewControllers = @[mainNav, infoNav];
    
    //Lancia l'applicazione principale.
    dispatch_async(dispatch_get_main_queue(),
    ^{
        [self.navigationController pushViewController: [Utilities appDelegate].tabBarController animated: YES];
    });
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
