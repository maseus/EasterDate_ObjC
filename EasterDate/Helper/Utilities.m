/**
 @file Utilities.m
 @brief Classe per la gestione di operazioni di comune utilità.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "Utilities.h"
#import "Enums.h"
#import "Constants.h"
#import "Colors.h"
#import "Fonts.h"
#import "Macros.h"

@implementation Utilities

/**
 @brief Metodo per la lettura di un'istanza del delegate dell'applicazione.
 @return Istanza del del delegate dell'applicazione.
 */
+ (AppDelegate *) appDelegate
{
    //Ritorna un'istanza del file AppDelegate.
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

/**
 @brief Metodo di istanza per verifica connessione di Rete.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isOnline
{
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    //Lancia un test di raggiungibilità su un host name di riferimento.
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.google.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    //Ritorna l'esito della verifica richiesta.
    return (receivedFlags && flags != 0);
}

/**
 @brief Metodo di istanza per la visualizzazione di una notifica Toast con durata predefinita.
 @param message Messaggio da visualizzare.
 */
+ (void) showToast: (NSString *) message
{
    //Visualizza la notifica prevista.
    [Utilities showToast: message duration: 3.0f];
}

/**
 @brief Metodo di istanza per la visualizzazione di una notifica Toast con durata indicata.
 @param message Messaggio da visualizzare.
 @param duration Durata prevista per la notifica.
 */
+ (void) showToast: (NSString *) message duration: (CGFloat) duration
{
    //Visualizza la notifica prevista.
    [KSToastView ks_showToast: NSLocalizedString(message, message) duration: REFRESH_DELAY * duration];
}

/**
 @brief Metodo di istanza per la lettura della lingua selezionata sul dispositivo.
 @return Stringa rappresentativa della lingua del dispositivo.
 */
+ (NSString *) getLanguage
{
    //Ritorna il risultato della verifica.
    return [[NSLocale preferredLanguages] objectAtIndex: 0];
}

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti all'inizio di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimLeft: (NSString *) string
{
    //Verifica stringa nulla.
    if (string == nil) return @"";
    
    //Verifica stringa vuota.
    if ([string isEqualToString: @""]) return string;
    
    //Definisce il range di caratteri da escludere.
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    int i;
    
    //Scansiona l'inizio della stringa.
    for (i = 0; i < string.length; i++)
    {
        //Termina la scansione quando rileva il primo carattere valido.
        if (![set characterIsMember: [string characterAtIndex: i]]) break;
    }
    
    //Ritorna il risultato dell'elaborazione.
    return [string substringFromIndex: i];
}

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti al termine di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimRight: (NSString *) string
{
    //Verifica stringa nulla.
    if (string == nil) return @"";
    
    //Verifica stringa vuota.
    if ([string isEqualToString: @""]) return string;
    
    //Definisce il range di caratteri da escludere.
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    int i;
    
    //Scansiona il termine della stringa.
    for (i = (int) (string.length - 1); i >= 0; i--)
    {
        //Termina la scansione quando rileva il primo carattere valido.
        if (![set characterIsMember: [string characterAtIndex: i]]) break;
    }
    
    //Ritorna il risultato dell'elaborazione.
    return [string substringToIndex: (i + 1)];
}

/**
 @brief Metodo di istanza per l'eliminazione di caratteri vuoti all'inizio ed al termine di una stringa.
 @param string Stringa di riferimento.
 @return Stringa risultato della formattazione.
 */
+ (NSString *) trimSides: (NSString *) string
{
    //Verifica stringa nulla.
    if (string == nil) return @"";
    
    //Verifica stringa vuota.
    if ([string isEqualToString: @""]) return string;
    
    //Applica i due metodi dedicati e ritorna il risultato finale.
    return [self trimRight: [self trimLeft: string]];
}

/**
 @brief Metodo di istanza per l'apertura di una pagina Web.
 @param url Percorso di Rete della pagina Web.
 */
+ (void) openUrl: (NSString *) url
{
    //Verifica il corretto formato dell'URL di riferimento.
    if (![url hasPrefix: @"http://"] && ![url hasPrefix: @"https://"]) url = [@"http://" stringByAppendingString: url];
    
    //Apre la pagina Web specificata.
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

/**
 @brief Metodo di istanza per l'apertura di un contatto Skype.
 @param skypeName Nome Skype del contatto di riferimento.
 */
+ (void) openSkype: (NSString *) skypeName
{
    //Lancia il servizio richiesto se disponibile.
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: @"skype://"]])
    {
        NSURL *skypeUrl = [NSURL URLWithString: [NSString  stringWithFormat: @"skype://?call=%@", skypeName]];
        [[UIApplication sharedApplication] openURL: skypeUrl];
    }
    //Altrimenti visualizza una notifica di errore.
    else [Utilities showToast: @"NoSupportAlert"];
}

/**
 @brief Metodo di istanza per l'estrazione del codice della lingua indicata.
 @param language Stringa rappresentativa della lingua di riferimento.
 @return Identificatore della lingua di riferimento.
 */
+ (int) getLanguage: (NSString *) language
{
    //Verifica la stringa della lingua di riferimento.
    if ([language isEqualToString: @"it"]) return ITALIAN;
    else if ([language isEqualToString: @"en"]) return ENGLISH;
    
    //Ritorna il risultato della verifica.
    return ENGLISH;
}

/**
 @brief Metodo di istanza per la regolazione dell'altezza di una ScrollView.
 @param scrollView ScrollView di riferimento.
 @param height Altezza da applicare.
 */
+ (void) adjustInset: (UIScrollView *) scrollView height: (CGFloat) height
{
    //Applica la modifica richiesta.
    UIEdgeInsets adjustInsets = UIEdgeInsetsMake(0, 0, height, 0);
    scrollView.contentInset = adjustInsets;
    scrollView.scrollIndicatorInsets = adjustInsets;
}

/**
 @brief Metodo di istanza per verifica di non nullità di una stringa.
 @param string Stringa di riferimento.
 @return Esito della verifica richiesta.
 */
+ (BOOL) notNull: (NSString *) string
{
    //Ritorna l'esito della verifica richiesta.
    return (string != nil && ![[Utilities trimSides: string] isEqualToString: @""]);
}

/**
 @brief Metodo di istanza per la creazione di un overlay da mostrare sul layout principale.
 @param dark Flag per la gestione del livello di trasparenza.
 @return Overlay generato.
 */
+ (UIView *) customOverlay: (BOOL) dark
{
    //Crea l'effetto richiesto.
    UIView *overlay = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    overlay.backgroundColor = [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha: (dark ? 0.2f : 0.1f)];
    
    //Ritorna l'effetto creato.
    return overlay;
}

/**
 @brief Metodo di istanza per verifica orientazione Portrait.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isPortrait
{
    //Ritorna l'esito della verifica richiesta.
    return ![self isLandscape];
}

/**
 @brief Metodo di istanza per verifica orientazione Landscape.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isLandscape
{
    //Ritorna l'esito della verifica richiesta.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    return (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) || ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft) || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight);
}

/**
 @brief Metodo di istanza per la personalizzazione di un campo di testo con placeholder mobile.
 @param field Campo di testo di riferimento.
 @param placeholderId Identificatore del testo da usare come placeholder.
 @param withLine Flag per la visualizzazione di una linea.
 */
+ (void) floatingField: (ACFloatingTextField *) field withPlaceholder: (NSString *) placeholderId withLine: (BOOL) withLine
{
    field.placeholder = NSLocalizedString(placeholderId, placeholderId);
    field.lineColor = (withLine ? MAIN_COLOR : [UIColor clearColor]);
    field.selectedLineColor = (withLine ? MAIN_COLOR : [UIColor clearColor]);
    field.placeHolderColor = HINT_COLOR;
    field.selectedPlaceHolderColor = MAIN_COLOR;
}

/**
 @brief Metodo per verifica di appartenenza di un valore ad un intervallo.
 @param start Valore iniziale dell'intervallo.
 @param end Valore finale dell'intervallo.
 @param value Valore da verificare.
 @return Esito della verifica richiesta.
 */
+ (BOOL) isBetween: (NSInteger) start and: (NSInteger) end value: (NSInteger) value
{
    //Ritorna l'esito della verifica richiesta.
    return (value >= start && value <= end);
}

/**
 @brief Metodo per il calcolo dei parametri per l'algoritmo di Gauss.
 @param year Anno di riferimento.
 @return Oggetto contenitore dei parametri richiesti.
 */
+ (NSMutableDictionary *) gaussParams: (NSInteger) year
{
    //Inizializza l'oggetto da restituire.
    NSMutableDictionary *gaussParams = [[NSMutableDictionary alloc] init];
    
    //Inizializza le variabili di riferimento.
    NSInteger startYear;
    NSInteger endYear;
    NSInteger mParam = -1;
    NSInteger nParam = -1;
    
    //Verifica l'intervallo di riferimento nella tabella di Gauss.
    for (NSMutableDictionary *gaussRange in [self appDelegate].gaussTable)
    {
        //Estrae gli anni di riferimento.
        startYear = [[gaussRange valueForKey: @"startYear"] integerValue];
        endYear = [[gaussRange valueForKey: @"endYear"] integerValue];
        
        //Verifica l'appartenenza dell'anno indicato allo specifico intervallo.
        if ([self isBetween: startYear and: endYear value: year])
        {
            //Estrae i parametri di riferimento.
            mParam = [[gaussRange valueForKey: @"mParam"] integerValue];
            nParam = [[gaussRange valueForKey: @"nParam"] integerValue];
            
            //Termina l'esecuzione del ciclo.
            break;
        }
    }
    
    //Compone l'oggetto di riferimento.
    [gaussParams setValue: [NSNumber numberWithInteger: mParam] forKey: @"mParam"];
    [gaussParams setValue: [NSNumber numberWithInteger: nParam] forKey: @"nParam"];
    
    //Restituisce l'oggetto creato.
    return gaussParams;
}

/**
 @brief Metodo di istanza per applicazione dell'algoritmo di Gauss al calcolo della data della Pasqua cristiana.
 @param year Anno di riferimento.
 @return Stringa rappresentativa della data calcolata.
 */
+ (NSString *) gaussAlgorithm: (NSInteger) year
{
    //Inizializza la stringa finale.
    NSString *easterDate = @"";
    
    //Inizializza i parametri iniziali.
    NSInteger mParam = -1;
    NSInteger nParam = -1;
    
    //Inizializza i parametri di lavoro.
    NSInteger aParam;
    NSInteger bParam;
    NSInteger cParam;
    NSInteger dParam;
    NSInteger eParam;
    
    //Calcola i parametri per l'algoritmo di Gauss.
    NSMutableDictionary *gaussParams = [self gaussParams: year];
    if ([gaussParams.allKeys containsObject: @"mParam"]) mParam = [[gaussParams valueForKey: @"mParam"] integerValue];
    if ([gaussParams.allKeys containsObject: @"nParam"]) nParam = [[gaussParams valueForKey: @"nParam"] integerValue];
    
    //Verifica parametri validi.
    if (mParam != -1 && nParam != -1)
    {
        //Calcola i parametri di lavoro.
        aParam = year % 4;
        bParam = year % 7;
        cParam = year % 19;
        dParam = (19 * cParam + mParam) % 30;
        eParam = (2 * aParam + 4 * bParam + 6 * dParam + nParam) % 7;
        
        //Calcola una prima data.
        if (dParam + eParam <= 9) easterDate = NSLocalizedFormatString(@"Date1", 22 + dParam + eParam);
        else easterDate = NSLocalizedFormatString(@"Date2", dParam + eParam - 9);
        
        //Verifica eventuali eccezioni.
        if ([easterDate isEqualToString: NSLocalizedString(@"Exception1", @"Exception1")] && dParam == 29 && eParam == 6) easterDate = NSLocalizedFormatString(@"Date2", 19);
        else if ([easterDate isEqualToString: NSLocalizedString(@"Exception2", @"Exception2")] && cParam > 10 && dParam == 28 && eParam == 6) easterDate = NSLocalizedFormatString(@"Date2", 18);
    }
    
    //Ritorna la data calcolata.
    return easterDate;
}

@end
