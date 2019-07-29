global class EmailHandlerCustomObjAttch implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
          Book__c book = new Book__c();
          book.From_Email__c = envelope.fromAddress;
          book.subject__c = email.subject;
          insert book;
          if(email.textAttachments != null)
          for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
            Attachment attachment = new Attachment();
            attachment.Name = tAttachment.fileName;
            String s = tAttachment.body;
            System.debug('TTTT');
            System.debug('____________'+s);
            attachment.Body = Blob.valueOf(tAttachment.body);
            attachment.ParentId = book.Id;
            insert attachment;
          }
          if(email.binaryAttachments != null)
          for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
            Attachment attachment = new Attachment();
            attachment.Name = bAttachment.fileName;
            attachment.Body = bAttachment.body;
            
            String hex = EncodingUtil.convertToHex( bAttachment.body);
    //System.assertEquals(0, hex.length() & 1);
    final Integer bytesCount = hex.length() >> 1;
    String[] bytes = new String[bytesCount];
    for(Integer i = 0; i < bytesCount; ++i)
        bytes[i] =  hex.mid(i << 1, 2);
    System.debug('\\\\'+EncodingUtil.urlDecode('%' + String.join(bytes, '%'), 'UTF-8'));
            /*
            String strOriginal = EncodingUtil.base64Encode(bAttachment.body);
             System.debug('11111'+strOriginal );
            Blob b = EncodingUtil.base64Decode(strOriginal);
             System.debug('22222'+b);
             string ss = EncodingUtil.urlEncode(strOriginal , 'ASCII');
                ss = EncodingUtil.urlDecode(ss, 'ASCII');
                System.debug('33333'+ss);
            String strUrlUTF8 = b.toString();
             System.debug('44444'+strUrlUTF8 );
            strOriginal = EncodingUtil.urlDecode(ss, 'UTF-8');

            System.debug('BBBb'+strOriginal );
            */
            attachment.ParentId = book.Id;
            insert attachment;
          }
          result.success = true;
          return result;
      }
  }