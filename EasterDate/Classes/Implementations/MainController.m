/**
 @file MainController.m
 @brief Classe per la gestione della schermata principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

#import "MainController.h"
#import "Utilities.h"
#import "Colors.h"
#import "Constants.h"
#import "Xib.h"

@implementation MainController

@synthesize scrollView;
@synthesize mainTitle;
@synthesize yearField;
@synthesize computeButton;
@synthesize resultView;
@synthesize resultLabel;
@synthesize easterDate;

/**
 @brief Metodo di sistema invocato per inizializzazione del layout.
 @param nibNameOrNil Nome del file di interfaccia di riferimento.
 @param nibBundleOrNil Bundle di riferimento.
 @return Istanza inizializzata.
 */
- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil
{
    //Invocato il metodo della superclasse.
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    
    //Inizializzazione personalizzata.
    if (self)
    {
        //Inizializza il titolo della barra di navigazione.
        self.navigationItem.title = NSLocalizedString(@"AppName", @"AppName");
        
        //Personalizza l'icona della relativa Tab.
        self.title = nil;
        self.tabBarItem.image = [UIImage imageNamed: @"main"];
        
        //Ricolloca l'icona nella Tab Bar.
        self.tabBarItem.imageInsets = TAB_INSETS;
        
        //Regola l'ampiezza delle Tab.
        [[UITabBar appearance] setItemWidth: ([Utilities isPortrait] ? SCREEN_WIDTH : SCREEN_HEIGHT) / TABS];
    }
    
    //Ritorna l'istanza inizializzata.
    return self;
}

/**
 @brief Metodo di sistema invocato al caricamento del layout.
 */
- (void) viewDidLoad
{
    //Invocato il metodo della superclasse.
    [super viewDidLoad];
    
    //Impedisce a specifici controlli di finire al di sotto della Tab Bar.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Adatta le dimensioni della ScrollView alla View principale.
    [scrollView setFrame: self.view.frame];
    
    //Colloca la ScrollView nella View principale.
    [self.view addSubview: scrollView];
    
    //Visualizza la barra di navigazione.
    [self.navigationController.navigationBar setHidden: NO];
    
    //Personalizza un pulsante per il ritorno a questa interfaccia.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @" " style: UIBarButtonItemStylePlain target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //Disattiva il ritorno alla schermata precedente usando la gesture di swipe verso sinistra.
    [self.navigationController.interactivePopGestureRecognizer setEnabled: NO];
    
    //Evita l'utilizzo di una Navigation Bar traslucida.
    [self.navigationController.navigationBar setTranslucent: NO];
    
    //Se possibile evita l'uso di una Tab Bar traslucida.
    [self.tabBarController.tabBar setTranslucent: NO];
    
    //Inizializza i componenti del layout.
    [self initLayout];
}

/**
 @brief Metodo di sistema per contesti di sovrautilizzo di memoria.
 */
- (void) didReceiveMemoryWarning
{
    //Invocato il metodo della superclasse.
    [super didReceiveMemoryWarning];
}

/**
 @brief Metodo per inizializzazione dei componenti del layout.
 */
- (void) initLayout
{
    //Valorizza il testo del titolo principale.
    mainTitle.text = NSLocalizedString(@"MainTitle", @"MainTitle");
    
    //Inizializza il campo di testo per l'inserimento dell'anno.
    yearField.delegate = self;
    [Utilities floatingField: yearField withPlaceholder: @"YearHint" withLine: YES];
    
    //Inizializza il pulsante per il calcolo richiesto.
    [computeButton setTitle: NSLocalizedString(@"ComputeButton", @"ComputeButton") forState: UIControlStateNormal];
    computeButton.layer.cornerRadius = (IS_IPAD ? 30.0f : 20.0f);
    computeButton.layer.shadowColor = INACTIVE_COLOR.CGColor;
    computeButton.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    computeButton.layer.shadowOpacity = 0.8;
    computeButton.layer.shadowRadius = 3.0f;
    computeButton.layer.masksToBounds = NO;
    
    //Inizializza il layout contenente il risultato richiesto.
    resultLabel.text = NSLocalizedString(@"EasterDay", @"EasterDay");
    easterDate.text = @"";
    resultView.hidden = YES;
    
    //Regola l'altezza della ScrollView principale.
    [Utilities adjustInset: scrollView height: [self scrollHeight]];
}

/**
 @brief Metodo per il calcolo dell'altezza del contenuto della ScrollView principale.
 @return Altezza per il contenimento dei controlli principali.
 */
- (CGFloat) scrollHeight
{
    CGFloat scrollHeight = 0.0f;
    scrollHeight = scrollHeight + mainTitle.frame.size.height;
    scrollHeight = scrollHeight + yearField.frame.size.height;
    scrollHeight = scrollHeight + computeButton.frame.size.height;
    if (!resultView.hidden) scrollHeight = scrollHeight + resultView.frame.size.height;
    return scrollHeight;
}

/**
 @brief Metodo per la gestione dell'anno indicato.
 */
- (void) handleYear
{
    //Legge l'anno indicato dall'utente.
    NSString *yearString = [Utilities trimSides: yearField.text];
    NSInteger year = ([Utilities notNull: yearString] ? [yearString integerValue] : 0);
    
    //Verifica il rispetto dei limiti consentiti.
    if (year >= MIN_YEAR && year <= MAX_YEAR)
    {
        //Chiude la tastiera eventualmente aperta.
        [yearField resignFirstResponder];
        
        //Applica l'algoritmo previsto.
        NSString *easter = [Utilities gaussAlgorithm: year];
        
        //Verifica una data non nulla.
        if ([Utilities notNull: easter])
        {
            //Visualizza la data calcolata.
            easterDate.text = easter;
            resultView.hidden = NO;
            [Utilities adjustInset: scrollView height: [self scrollHeight]];
        }
        else
        {
            //Nasconde il risultato finale.
            resultView.hidden = YES;
            [Utilities adjustInset: scrollView height: [self scrollHeight]];
        }
    }
    else
    {
        //Notifica il mancato inserimento di uno sconto.
        [Utilities showToast: @"WrongYearAlert"];
        
        //Nasconde il risultato finale.
        resultView.hidden = YES;
        [Utilities adjustInset: scrollView height: [self scrollHeight]];
    }
}

/**
 @brief Metodo gestore della variazione del testo contenuto in un campo di testo.
 @param textField Campo di testo di riferimento.
 @param range Intervallo interessato dalla variazione.
 @param string Stringa rappresentativa del testo variato.
 @return Esito della gestione dell'operazione.
 */
- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string
{
    //Gestisce solo il campo di testo per l'inserimento dell'anno.
    if ([textField isEqual: yearField])
    {
        //Gestisce l'attivazione del pulsante di conferma.
        NSString *year = [textField.text stringByReplacingCharactersInRange: range withString: string];
        computeButton.enabled = [Utilities notNull: year];
        
        //Gestisce la visibilità del risultato finale.
        if (![Utilities notNull: year])
        {
            resultView.hidden = YES;
            [Utilities adjustInset: scrollView height: [self scrollHeight]];
        }
        
        //Operazione correttamente gestita.
        return YES;
    }
    
    //Operazione non gestita.
    return NO;
}

/**
 @brief Metodo di sistema per interazione con i campi di testo.
 @param textField Campo di testo di riferimento.
 @return Esito della gestione dell'operazione.
 */
- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    //Gestisce solo il campo di testo per l'inserimento dell'anno.
    if ([textField isEqual: yearField])
    {
        //Verifica l'inserimento di un anno.
        if ([Utilities notNull: textField.text])
        {
            //Verifica e gestisce l'anno inserito.
            [self handleYear];
        }
        else
        {
            //Notifica il mancato inserimento di uno sconto.
            [Utilities showToast: @"WrongYearAlert"];
            
            //Nasconde il risultato finale.
            resultView.hidden = YES;
            [Utilities adjustInset: scrollView height: [self scrollHeight]];
        }
        
        //Operazione correttamente gestita.
        return YES;
    }
    
    //Operazione non gestita.
    return NO;
}

/**
 @brief Metodo di interazione con il pulsante per il calcolo richiesto.
 @param sender Controllo oggetto di interazione.
 */
- (IBAction) computeResult: (id) sender
{
    //Effetto di animazione grafica.
    computeButton.alpha = 0.4f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        computeButton.alpha = 1.0f;
    });
    
    //Verifica e gestisce l'anno inserito.
    [self handleYear];
}

/**
 @brief Metodo gestore della possibile rotazione del layout.
 @return Esito della verifica richiesta.
 */
- (BOOL) canAutoRotate
{
    return IS_IPAD;
}

@end
