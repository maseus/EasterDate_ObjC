/**
 @file Xib.h
 @brief Definizione di file di interfaccia in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "Utilities.h"
#import "Macros.h"

#ifndef Xib_h
#define Xib_h

#define SPLASH_XIB (IS_IPAD ? @"SplashController_iPad" : @"SplashController")
#define MAIN_XIB (IS_IPAD ? @"MainController_iPad" : @"MainController")
#define INFO_XIB (IS_IPAD ? @"InfoController_iPad" : @"InfoController")
#define ALGORITHM_XIB (IS_IPAD ? @"AlgorithmController_iPad" : @"AlgorithmController")

#endif
