/**
 @file AppDelegate.h
 @brief Classe per la gestione dell'applicazione principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    /** @brief Tab Bar di riferimento. */
    UITabBarController *tabBarController;
    
    /** @brief Finestra principale dell'applicazione. */
    UIWindow *window;
    
    /** @brief Punto di accesso alle informazioni condivise. */
    NSUserDefaults *defaults;
    
    /** @brief Riferimento all'applicazione principale. */
    UIApplication *mainApp;
    
    /** @brief Tabella dell'algoritmo di Gauss. */
    NSMutableArray *gaussTable;
}

/** @brief Tab Bar di riferimento. */
@property (strong, nonatomic) UITabBarController *tabBarController;

/** @brief Finestra principale dell'applicazione. */
@property (strong, nonatomic) UIWindow *window;

/** @brief Riferimento all'applicazione principale. */
@property (strong, nonatomic) UIApplication *mainApp;

/** @brief Tabella dell'algoritmo di Gauss. */
@property (strong, nonatomic) NSMutableArray *gaussTable;

/**
 @brief Metodo di istanza per la lettura della lingua del dispositivo.
 @return Identificatore della lingua del dispositivo.
 */
+ (int) deviceLanguage;

@end
