public class URLDecodingHide {
    Blob urlParameter;
    public String decryptedString {set;get;}
    public String decrypted {set;get;}
    public URLDecodingHide(){
        urlParameter = Blob.valueOf(ApexPages.currentPage().getParameters().get('contId'));
        decrypted = String.valueOf(ApexPages.currentPage().getParameters().get('contId'));
        /*Blob key = Crypto.generateAesKey(128);
        Blob decrypted = Crypto.decryptWithManagedIV('AES128', key, urlParameter);
        decryptedString = decrypted.toString();
        System.debug('ddddd ==='+decryptedString);*/
    }
}