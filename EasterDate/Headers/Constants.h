/**
 @file Constants.h
 @brief Definizione delle costanti in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "Utilities.h"

#ifndef Constants_h
#define Constants_h

/** @brief Numero di schermate nell'applicazione principale. */
#define TABS 2

/** @brief Tempo di aggiornamento schermate. */
#define REFRESH_DELAY 1.0f

/** @brief Anno minimo di riferimento. */
#define MIN_YEAR 34

/** @brief Anno massimo di riferimento. */
#define MAX_YEAR 2499

/** @brief Percorso di Rete del profilo Facebook dell'autore. */
#define FACEBOOK_URL @"https://www.facebook.com/maseus85"

/** @brief Percorso di Rete del profilo LinkedIn dell'autore. */
#define LINKEDIN_URL @"https://@brief www.linkedin.com/in/eustachio-maselli-9a2466101"

/** @brief Percorso di Rete del profilo GitHub dell'autore. */
#define GITHUB_URL @"https://github.com/maseus"

/** @brief Nome Skype dell'autore. */
#define SKYPE_NAME @"maseus85"

/** @brief Indirizzo e-mail dell'autore. */
#define MAIL_ADDRESS @"maseus@hotmail.it"

/** @brief Larghezza di riferimento per dispositivo iPad 9.7 inch. */
#define IPAD_AIR_WIDTH 768.0f

/** @brief Altezza di riferimento per dispositivo iPad 9.7 inch. */
#define IPAD_AIR_HEIGHT 1024.0f

/** @brief Larghezza di riferimento per dispositivo iPad 12.9 inch. */
#define IPAD_PRO_WIDTH 1024.0f

/** @brief Altezza di riferimento per dispositivo iPad 12.9 inch. */
#define IPAD_PRO_HEIGHT 1366.0f

/** @brief Parametr0 per il posizionamento delle Tab. */
#define TAB_INSETS UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f)

/** @brief Dimensione per gli indicatori di aggiornamento. */
#define SPINNER_SIZE (IS_IPAD ? 60.0f : 40.0f)

#endif
