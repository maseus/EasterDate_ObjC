/**
 @file SplashController.h
 @brief Classe per la gestione della schermata di lancio.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface SplashController : UIViewController
    
/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate;

@end
