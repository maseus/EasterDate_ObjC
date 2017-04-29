/**
 @file Macros.h
 @brief Definizione di macro in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "Utilities.h"

#ifndef Macros_h
#define Macros_h

/** @brief Macro per il riconoscimento di dispositivo iPad. */
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** @brief Macro per il riconoscimento di dispositivo iPhone. */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** @brief Macro per il riconoscimento di dispositivo con display Retina. */
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector: @selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f)

/** @brief Macro per il riconoscimento di dispositivo iPhone 4 o minore. */
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 480.0f)

/** @brief Macro per il riconoscimento di dispositivo iPhone 5, 5s. */
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0f)

/** @brief Macro per il riconoscimento di dispositivo iPhone 6, 6s, 7. */
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0f)

/** @brief Macro per il riconoscimento di dispositivo iPhone 6 Plus, 6s Plus, 7 Plus. */
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0f)

/** @brief Macro per il riconoscimento di dispositivo iPad Air, Air 2, Pro 9,7 pollici. */
#define IS_IPAD_AIR (IS_IPAD && MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 1024.0f)

/** @brief Macro per il riconoscimento di dispositivo iPad Pro 12,9 pollici. */
#define IS_IPAD_PRO (IS_IPAD && MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 1366.0f)

/** @brief Macro per il calcolo della larghezza del display del dispositivo. */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/** @brief Macro per il calcolo dell'altezza del display del dispositivo. */
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

/** @brief Macro per il calcolo della dimensione massima del display del dispositivo. */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

/** @brief Macro per il calcolo della dimensione minima del display del dispositivo. */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/** @brief Macro per il riconoscimento di versione di iOS uguale o superiore alla 7. */
#define IS_OS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)

/** @brief Macro per il riconoscimento di versione di iOS uguale o superiore alla 8. */
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)

/** @brief Macro per il riconoscimento di versione di iOS uguale o superiore alla 9. */
#define IS_OS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)

/** @brief Macro per la rotazione dei testi. */
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0f)

/** @brief Macro per la creazione di un testo parametrico. */
#define NSLocalizedFormatString(fmt, ...) [NSString stringWithFormat: NSLocalizedString(fmt, nil), __VA_ARGS__]

#endif
