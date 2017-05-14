/**
 @file AlgorithmController.h
 @brief Classe per la gestione della schermata per la pagina Web dell'algoritmo.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "DRPLoadingSpinner.h"

@interface AlgorithmController : UIViewController <UIWebViewDelegate>
{
    /** @brief WebView principale di riferimento. */
    IBOutlet UIWebView *algorithmContent;
    
    /** @brief Indicatore di comunicazione con il server. */
    DRPLoadingSpinner *serverProgress;
    
    //Overlay associato alla comunicazione con il server. */
    UIView *viewOverlay;
}

/** @brief WebView principale di riferimento. */
@property (strong, nonatomic) IBOutlet UIWebView *algorithmContent;

/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate;

@end
