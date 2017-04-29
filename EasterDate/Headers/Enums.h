/**
 @file Enums.h
 @brief Definizione di enumerazioni in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#ifndef Enums_h
#define Enums_h

/**
 @typedef AppTab
 @brief Enumerazione delle Tab dell'applicazione principale.
 @field MAIN_TAB Tab della schermata principale.
 @field INFO_TAB Tab della schermata informativa.
 */
typedef NS_ENUM (NSUInteger, AppTab)
{
    MAIN_TAB = 0,
    INFO_TAB = 1,
};

/**
 @typedef DeviceLanguage
 @brief Enumerazione delle lingue gestite dall'applicazione.
 @field ITALIAN Italiano.
 @field ENGLISH Inglese.
 */
typedef NS_ENUM (NSUInteger, DeviceLanguage)
{
    ITALIAN = 0,
    ENGLISH = 1
};

#endif
