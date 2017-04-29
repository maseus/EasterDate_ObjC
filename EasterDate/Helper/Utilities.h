/**
 @file Utilities.h
 @brief Classe per la gestione di operazioni di comune utilità.
 @author Eustachio Maselli
 @copyright © 2017 Bewons Company S.r.l. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "KSToastView.h"
#import "ACFloatingTextField.h"
#import "AppDelegate.h"
#import "Enums.h"

@class AppDelegate;

@interface Utilities : NSObject

/**
 @brief Metodo per la lettura di un'istanza del delegate dell'applicazione.
 @return Istanza del del delegate dell'applicazione.
 */
+ (AppDelegate *) appDelegate;

/**
 @brief Metodo di istanza per verifica connessione di Rete.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isOnline;

/**
 @brief Metodo di istanza per la visualizzazione di una notifica Toast con durata predefinita.
 @param message Messaggio da visualizzare.
 */
+ (void) showToast: (NSString *) message;

/**
 @brief Metodo di istanza per la visualizzazione di una notifica Toast con durata indicata.
 @param message Messaggio da visualizzare.
 @param duration Durata prevista per la notifica.
 */
+ (void) showToast: (NSString *) message duration: (CGFloat) duration;

/**
 @brief Metodo di istanza per la lettura della lingua selezionata sul dispositivo.
 @return Stringa rappresentativa della lingua del dispositivo.
 */
+ (NSString *) getLanguage;

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti all'inizio di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimLeft: (NSString *) string;

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti al termine di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimRight: (NSString *) string;

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti all'inizio ed al termine di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimSides: (NSString *) string;

/**
 @brief Metodo di istanza per l'apertura di una pagina Web.
 @param url Percorso di Rete della pagina Web.
 */
+ (void) openUrl: (NSString *) url;

/**
 @brief Metodo di istanza per l'apertura di un contatto Skype.
 @param skypeName Nome Skype del contatto di riferimento.
 */
+ (void) openSkype: (NSString *) skypeName;

/**
 @brief Metodo di istanza per l'estrazione del codice della lingua indicata.
 @param language Stringa rappresentativa della lingua di riferimento.
 @return Identificatore della lingua di riferimento.
 */
+ (int) getLanguage: (NSString *) language;

/**
 @brief Metodo di istanza per la regolazione dell'altezza di una ScrollView.
 @param scrollView ScrollView di riferimento.
 @param height Altezza da applicare.
 */
+ (void) adjustInset: (UIScrollView *) scrollView height: (CGFloat) height;

/**
 @brief Metodo di istanza per verifica di non nullità di una stringa.
 @param string Stringa di riferimento.
 @return Esito della verifica richiesta.
 */
+ (BOOL) notNull: (NSString *) string;

/**
 @brief Metodo di istanza per la creazione di un overlay da mostrare sul layout principale.
 @param dark Flag per la gestione del livello di trasparenza.
 @return Overlay generato.
 */
+ (UIView *) customOverlay: (BOOL) dark;

/**
 @brief Metodo di istanza per verifica orientazione Portrait.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isPortrait;

/**
 @brief Metodo di istanza per verifica orientazione Landscape.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isLandscape;

/**
 @brief Metodo di istanza per la personalizzazione di un campo di testo con placeholder mobile.
 @param field Campo di testo di riferimento.
 @param placeholderId Identificatore del testo da usare come placeholder.
 @param withLine Flag per la visualizzazione di una linea.
 */
+ (void) floatingField: (ACFloatingTextField *) field withPlaceholder: (NSString *) placeholderId withLine: (BOOL) withLine;

/**
 @brief Metodo di istanza per applicazione dell'algoritmo di Gauss al calcolo della data della Pasqua cristiana.
 @param year Anno di riferimento.
 @return Stringa rappresentativa della data calcolata.
 */
+ (NSString *) gaussAlgorithm: (NSInteger) year;

@end
