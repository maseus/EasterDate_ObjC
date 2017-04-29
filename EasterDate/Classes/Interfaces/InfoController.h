/**
 @file InfoController.h
 @brief Classe per la gestione della schermata informativa.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "KSToastView.h"

@interface InfoController : UIViewController <MFMailComposeViewControllerDelegate>
{
    /** @brief ScrollView principale. */
    IBOutlet UIScrollView *scrollView;
    
    /** @brief Titolo principale della schermata. */
    IBOutlet UILabel *infoTitle;
    
    /** @brief Etichetta del numero di versione. */
    IBOutlet UILabel *versionLabel;
    
    /** @brief Informazione sul numero di versione. */
    IBOutlet UILabel *versionCode;
    
    /** @brief Etichetta del nome dell'autore. */
    IBOutlet UILabel *authorLabel;
    
    /** @brief Informazione sull'autore. */
    IBOutlet UILabel *authorInfo;
    
    /** @brief Layout contenente i pulsanti per i profili dell'autore. */
    IBOutlet UIView *badgeView;
    
    /** @brief Pulsante per il profilo Facebook dell'autore. */
    IBOutlet UIButton *facebookBadge;
    
    /** @brief Pulsante per il profilo LinkedIn dell'autore. */
    IBOutlet UIButton *linkedinBadge;
    
    /** @brief Pulsante per il profilo GitHub dell'autore. */
    IBOutlet UIButton *githubBadge;
    
    /** @brief Pulsante per il profilo Skype dell'autore. */
    IBOutlet UIButton *skypeBadge;
    
    /** @brief Pulsante per il contatto e-mail dell'autore. */
    IBOutlet UIButton *mailBadge;
    
    /** @brief Link alla pagina Wikipedia dell'algoritmo. */
    IBOutlet UIButton *algorithmLink;
}

/** @brief ScrollView principale. */
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

/** @brief Titolo principale della schermata. */
@property (strong, nonatomic) IBOutlet UILabel *infoTitle;

/** @brief Etichetta del numero di versione. */
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

/** @brief Informazione sul numero di versione. */
@property (strong, nonatomic) IBOutlet UILabel *versionCode;

/** @brief Etichetta del nome dell'autore. */
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

/** @brief Informazione sull'autore. */
@property (strong, nonatomic) IBOutlet UILabel *authorInfo;

/** @brief Layout contenente i pulsanti per i profili dell'autore. */
@property (strong, nonatomic) IBOutlet UIView *badgeView;

/** @brief Pulsante per il profilo Facebook dell'autore. */
@property (strong, nonatomic) IBOutlet UIButton *facebookBadge;

/** @brief Pulsante per il profilo LinkedIn dell'autore. */
@property (strong, nonatomic) IBOutlet UIButton *linkedinBadge;

/** @brief Pulsante per il profilo GitHub dell'autore. */
@property (strong, nonatomic) IBOutlet UIButton *githubBadge;

/** @brief Pulsante per il profilo Skype dell'autore. */
@property (strong, nonatomic) IBOutlet UIButton *skypeBadge;

/** @brief Pulsante per il contatto e-mail dell'autore. */
@property (strong, nonatomic) IBOutlet UIButton *mailBadge;

/** @brief Link alla pagina Wikipedia dell'algoritmo. */
@property (strong, nonatomic) IBOutlet UIButton *algorithmLink;

/**
 @brief Metodo di interazione con i pulsanti per i profili dell'autore.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) handleBadge: (id) sender;

/**
 @brief Metodo di interazione con il link alla pagina Wikipedia dell'algoritmo.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) showWebPage: (id) sender;

/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate;

@end
