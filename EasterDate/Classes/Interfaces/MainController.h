/**
 @file MainController.h
 @brief Classe per la gestione della schermata principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KSToastView.h"
#import "ACFloatingTextField.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface MainController : UIViewController <UITextFieldDelegate>
{
    /** @brief ScrollView principale. */
    IBOutlet TPKeyboardAvoidingScrollView *scrollView;
    
    /** @brief Titolo principale della schermata. */
    IBOutlet UILabel *mainTitle;
    
    /** @brief Campo di testo per l'inserimento dell'anno. */
    IBOutlet ACFloatingTextField *yearField;
    
    /** @brief Pulsante per il calcolo richiesto. */
    IBOutlet UIButton *computeButton;
    
    /** @brief Layout del risultato finale. */
    IBOutlet UIView *resultView;
    
    /** @brief Etichetta del risultato finale. */
    IBOutlet UILabel *resultLabel;
    
    /** @brief Campo per il risultato finale. */
    IBOutlet UILabel *easterDate;
}

/** @brief ScrollView principale. */
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

/** @brief Titolo principale della schermata. */
@property (strong, nonatomic) IBOutlet UILabel *mainTitle;

/** @brief Campo di testo per l'inserimento dell'anno. */
@property (strong, nonatomic) IBOutlet ACFloatingTextField *yearField;

/** @brief Pulsante per il calcolo richiesto. */
@property (strong, nonatomic) IBOutlet UIButton *computeButton;

/** @brief Layout del risultato finale. */
@property (strong, nonatomic) IBOutlet UIView *resultView;

/** @brief Etichetta del risultato finale. */
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

/** @brief Campo per il risultato finale. */
@property (strong, nonatomic) IBOutlet UILabel *easterDate;

/**
 @brief Metodo di interazione con il pulsante per il calcolo richiesto.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) computeResult: (id) sender;

/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate;

@end
