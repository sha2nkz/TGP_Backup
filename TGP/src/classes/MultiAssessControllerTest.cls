/*
Author : Shridhar Patankar
Story  : Story-0166/SOL_069 
Description : Test Class for MultiAssessController. 

Updated by        Story no.                Update Date        Update details
------------    -----------------        --------------    -------------------------------------------------------------


*/
@isTest(SeeAlldata= true)
private class MultiAssessControllerTest{
  static User testUser; 
  static User testUser1; 
   static Client_Master__c clientName;
   static Client_Geo_Area_Master__c clientGeoArea;
   static Operating_Group_Master__c operatingGroup;
   static Client_Geo_Unit_Master__c clientGeoUnit;
   static Opportunity_TGP__c oppTGP;
   static Service_Master__c serviceMaster; 
   static Assumption_Master__c assumptionMaster;
   static Offerings_Master__c offeringMaster;
   static Opportunity_Offering__c oppOffering;
   static Assumption__c assumption;
   static Current_Client_Capability_Assessment__c ccca;
   static Document doc;
   static ApexPages.StandardController sc;
   static String USER_Name = 'vc7@testorg.com';
    public static void setupData(){
     Profile p = UTIL_DataCreationForTestClass.getProfile(UTIL_Constants.WORKBENCH_USER);
     
     testUser = UTIL_DataCreationForTestClass.getUserWithProfile(p,UTIL_Constants.USER_NAME);
     Database.insert(testUser, false);
     
      Profile p1 = UTIL_DataCreationForTestClass.getProfile(UTIL_Constants.SOLUTION_ADMIN);
     
     testUser1 = UTIL_DataCreationForTestClass.getUserWithProfile(p1,USER_Name);
     Database.insert(testUser1, false);
     
      //system.Runas(testUser1)
     //{
      clientName = new Client_Master__c (Name = 'TestObject1',Active__c = true);
      insert clientName;
      
      clientGeoArea = new Client_Geo_Area_Master__c (Name = 'TestAPAC',Active__c = true);
      insert clientGeoArea;
      
      operatingGroup = new Operating_Group_Master__c (Name = 'TestHSMPS',Active__c = true);
      insert operatingGroup;
      
      clientGeoUnit = new Client_Geo_Unit_Master__c (Name = 'TestLATAM',Active__c = true);
      insert clientGeoUnit;
      
     
     //}
     //system.Runas(testUser)
     //{
      oppTGP = new Opportunity_TGP__c(Name = 'TestIBM',Stage__c='Stage 1',Client_Name__c= clientName.id ,Client_Geo_Area__c=clientGeoArea.id,Operating_Group__c=operatingGroup.id,Risk_Level__c='Low',
                  Expected_contract_sign_qtr__c='FY12-Q4',Client_Geo_Unit__c=clientGeoUnit.id ,Activity__c='1-Active',Enterprise_Solution_Architect__c=testUser.id ,
                  Oppotunity_QA__c='ShridharTest',OG_Sales_Lead__c='ShridharTest');
      insert oppTGP;
     // }
   }
    public static void setupData00(){
    setupData();
     offeringMaster = new Offerings_Master__c (Name = 'TestOffering',Active__c = true);
     insert offeringMaster;
     
      
     
     assumptionMaster = new Assumption_Master__c(Category__c = 'TestCategory',Assumption__c = 'TestData',Active_Inactive__c = true);
     insert assumptionMaster;
      oppOffering = new Opportunity_Offering__c(Offering_Text_Name__c = 'TestOffering',Opportunity_TGP__c=oppTGP.id);
     insert oppOffering;
     
     serviceMaster = new Service_Master__c(Name = 'TestService',Offering__c = offeringMaster.id,Active__c = true );
      insert serviceMaster;
     
      assumption= new Assumption__c (Name = 'TestAssumption',Assumption_Master__c = assumptionMaster.id,Category__c = 'TestPeople',Editable__c =True,Applicable__c = True,Opportunity_Offering__c= oppOffering.id );
     insert assumption;
     
     ccca = new Current_Client_Capability_Assessment__c(File_ID__c = 'TEstID1234',File_Name__c = 'TEstName',Opportunity_TGP__c =oppTGP.id,Comments__c = 'abc' );
     insert ccca;
     /*Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
     doc = new Document(Name = 'TestDoc',FolderId =testUser.id,AuthorId =testUser.id,body =Blob.valueOf('I am a test'));
     insert doc;*/
    sc = new ApexPages.StandardController(oppOffering); 
   }
    static testMethod void testMultiAssessController(){
       test.starttest();
       String fileName;
       String fileID;
       String comments;
          setupData00();
           PageReference pageRef= Page.assessmentUpload;
           pageRef.getParameters().put('id', String.valueOf(oppOffering.Id));
          Test.setCurrentPageReference(pageRef);
      ApexPages.StandardController controller= new ApexPages.StandardController(oppOffering);
         // ApexPages.StandardController controller;
          apexpages.currentpage().getparameters().put('id' ,oppOffering.id);
         MultiAssessController multiAccessController = new MultiAssessController( sc);
         MultiAssessController.DisplayFile displayFile = new MultiAssessController.DisplayFile(fileName,fileID,comments);
        
         
         multiAccessController.initializeDetailRecords();
         Document doc2 = multiAccessController.doc1;
            doc2.Name = 'TESTDOC123456789';
            doc2.body = Blob.valueOf('I am a test');
            doc2.Description = 'Test Description';
        
    
         PageReference upload= multiAccessController.upload();
         PageReference saveNow= multiAccessController.saveNow();
         PageReference cancelNow= multiAccessController.cancelNow();
         PageReference deleteFile= multiAccessController.deleteFile();
          multiAccessController.getFileIdDelete();
           multiAccessController.getDisplay1();
           multiAccessController.getComments();
            
             
       test.stoptest(); 
   } 
}