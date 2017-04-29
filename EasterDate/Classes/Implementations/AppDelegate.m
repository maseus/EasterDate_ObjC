/**
 @file AppDelegate.m
 @brief Classe per la gestione dell'applicazione principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "AppDelegate.h"
#import "SplashController.h"
#import "Utilities.h"
#import "Enums.h"
#import "Fonts.h"
#import "Constants.h"
#import "Colors.h"
#import "Xib.h"

@implementation AppDelegate

@synthesize tabBarController;
@synthesize window;
@synthesize mainApp;
@synthesize gaussTable;

/** @brief Lingua selezionata sul dispositivo. */
NSString *language;

/**
 @brief Metodo di sistema invocato al lancio dell'applicazione.
 @param application Istanza dell'applicazione principale.
 @param launchOptions Opzione specifiche per il lancio.
 @return Esito della gestione dell'operazione.
 */
- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
    //Inizializza il listener di variazioni nell'orientazione del dispositivo.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    //Registra il riferimento all'applicazione principale.
    self.mainApp = application;
    
    //Inizializza il punto di accesso alle informazioni condivise.
    defaults = [NSUserDefaults standardUserDefaults];
    
    //Determina e traccia la lingua selezionata sul dispositivo.
    NSArray *languages = [defaults objectForKey: @"AppleLanguages"];
    language = [languages objectAtIndex: 0];
    
    //Inizializza la tabella dell'algoritmo di Gauss.
    [self initGaussTable];
    
    //Lancia l'applicazione principale.
    [self startApp];
    
    //Operazione correttamente gestita.
    return YES;
}

/**
 @brief Metodo di sistema gestore della rotazione dei layout dell'applicazione.
 @param application Istanza dell'applicazione principale.
 @param window Finestra dell'applicazione principale.
 @return Oggetto rappresentativa dell'orientazione prevista.
 */
- (UIInterfaceOrientationMask) application: (UIApplication *) application supportedInterfaceOrientationsForWindow: (UIWindow *) window
{
    //Legge il controller corrente di riferimento.
    UIViewController *currentController = [self topViewController];
    
    if ([currentController respondsToSelector: @selector(canAutoRotate)])
    {
        NSMethodSignature *signature = [currentController methodSignatureForSelector: @selector(canAutoRotate)];
        
        //Legge il metodo di riferimento nel controller.
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: signature];
        [invocation setSelector: @selector(canAutoRotate)];
        [invocation setTarget: currentController];
        [invocation invoke];
        
        //Verifica la scelta per il singolo layout.
        BOOL canAutorotate = NO;
        [invocation getReturnValue: &canAutorotate];
        if (canAutorotate) return UIInterfaceOrientationMaskAll;
    }
    
    //Ipotesi solo orientamento Portrait.
    return UIInterfaceOrientationMaskPortrait;
}

/**
 @brief Metodo di sistema invocato all'attivazione dell'applicazione.
 @param application Istanza dell'applicazione principale.
 */
- (void) applicationDidBecomeActive: (UIApplication *) application
{
    //TODO
}

/**
 @brief Metodo di sistema invocato alla disattivazione dell'applicazione.
 @param application Istanza dell'applicazione principale.
 */
- (void) applicationWillResignActive: (UIApplication *) application
{
    //TODO
}

/**
 @brief Metodo di sistema invocato alla terminazione dell'applicazione.
 @param application Istanza dell'applicazione principale.
 */
- (void) applicationWillTerminate: (UIApplication *) application
{
    //TODO
}

/**
 @brief Metodo di sistema invocato per esecuzione in background.
 @param application Istanza dell'applicazione principale.
 */
- (void) applicationDidEnterBackground: (UIApplication *) application
{
    //TODO
}

/**
 @brief Metodo di sistema invocato per esecuzione in foreground.
 @param application Istanza dell'applicazione principale.
 */
- (void) applicationWillEnterForeground: (UIApplication *) application
{
    //TODO
}

/**
 @brief Metodo per la determinazione della schermata oggetto di interazione.
 @return Schermata esito della verifica.
 */
- (UIViewController *) topViewController
{
    return [self topViewControllerWithRootViewController: [UIApplication sharedApplication].keyWindow.rootViewController];
}

/**
 @brief Metodo per la determinazione della schermata oggetto di interazione.
 @param rootViewController ViewController principale di riferimento.
 @return Schermata esito della verifica.
 */
- (UIViewController *) topViewControllerWithRootViewController: (UIViewController *) rootViewController
{
    //Lancia la verifica richiesta.
    if ([rootViewController isKindOfClass: [UITabBarController class]])
    {
        UITabBarController *tabController = (UITabBarController *) rootViewController;
        return [self topViewControllerWithRootViewController: tabController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass: [UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *) rootViewController;
        return [self topViewControllerWithRootViewController: navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController: presentedViewController];
    }
    else return rootViewController;
}

/**
 @brief Metodo per inizializzazione della tabella dell'algoritmo di Gauss.
 */
- (void) initGaussTable
{
    //Inizializza la struttura dati di riferimento.
    gaussTable = [[NSMutableArray alloc] init];
    NSMutableDictionary *gaussRange;
    
    //Compone gli intervalli di riferimento.
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 34] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1582] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 15] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 6] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 1583] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1699] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 22] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 1700] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1799] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 23] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 3] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 1800] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1899] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 23] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 4] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 1900] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1999] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 24] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 5] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 2000] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2099] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 24] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 5] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 2100] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2199] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 24] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 6] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 2200] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2299] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 25] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 0] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 2300] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2399] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 26] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
    
    gaussRange = [[NSMutableDictionary alloc] init];
    [gaussRange setValue: [NSNumber numberWithInteger: 2400] forKey: @"startYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 2499] forKey: @"endYear"];
    [gaussRange setValue: [NSNumber numberWithInteger: 25] forKey: @"mParam"];
    [gaussRange setValue: [NSNumber numberWithInteger: 1] forKey: @"nParam"];
    [gaussTable addObject: gaussRange];
}

/**
 @brief Metodo per il lancio dell'applicazione principale.
 */
- (void) startApp
{
    //Inizializza la finestra principale.
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    //Inizializza la schermata di lancio dell'applicazione.
    SplashController *splash = [[SplashController alloc] initWithNibName: SPLASH_XIB bundle: nil];
    UINavigationController *splashNav = [[UINavigationController alloc] initWithRootViewController: splash];
    
    //Personalizza l'aspetto del titolo nella barra di navigazione.
    [[UINavigationBar appearance] setTintColor: MAIN_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName: [UIFont fontWithName: ROBOTO_BOLD size: (IS_IPAD ? 25.0f : 20.0f)], NSForegroundColorAttributeName: BLACK_COLOR}];
    
    //Personalizza l'aspetto della Tab Bar principale.
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [[UITabBarItem appearance] titleTextAttributesForState: UIControlStateNormal]];
    [attributes setValue: [UIFont fontWithName: ROBOTO_BOLD size: (IS_IPAD ? 23.0f : 19.0f)] forKey: NSFontAttributeName];
    [attributes setValue: MAIN_COLOR forKey: NSForegroundColorAttributeName];
    [[UITabBarItem appearance] setTitleTextAttributes: attributes forState: UIControlStateNormal];
    [[UITabBar appearance] setTintColor: MAIN_COLOR];
    [[UITabBar appearance] setBarTintColor: WHITE_COLOR];
    
    //Personalizza il colore del cursore nei campi di testo.
    [[UITextField appearance] setTintColor: MAIN_COLOR];
    
    //Visualizza la schermata di avvio nella finestra principale.
    [self.window setRootViewController: splashNav];
    [self.window makeKeyAndVisible];
}

/**
 @brief Metodo di istanza per la lettura della lingua del dispositivo.
 @return Identificatore della lingua del dispositivo.
 */
+ (int) deviceLanguage
{
    int langId = -1;
    
    //Determina la lingua selezionata sul dispositivo.
    if ([language isEqualToString: @"it-IT"]) langId = ITALIAN;
    else langId = ENGLISH;
    
    //Ritorna il risultato della verifica.
    return langId;
}

@end
