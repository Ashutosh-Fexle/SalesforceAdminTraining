public class AddPrimaryContact implements Queueable 
{
    private Contact contact;
    private String stateAbbr;

    public AddPrimaryContact(Contact contact, String stateAbbr) 
    {
        System.debug('Entering constructor :');
        this.contact = contact;
        this.stateAbbr = stateAbbr;
        System.debug('contact and stateAbbr :- '+this.contact+this.stateAbbr);
        System.debug('Exiting constructor :');
    }

    public void execute(QueueableContext ctx) 
    {
        
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :stateAbbr LIMIT 200];
        System.debug('accounts list:'+accounts);

        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : accounts) 
        {
            Contact clonedContact = contact.clone(false, false, false, false);
            clonedContact.AccountId = acc.Id;
            contactsToInsert.add(clonedContact);
        }

        if (!contactsToInsert.isEmpty()) 
        {
            System.debug('contactsToInsert:'+contactsToInsert);
            insert contactsToInsert;
        }
    }
}