@isTest
private class AnimalLocatorTest {
    @isTest static void AnimalLocatorMock1(){
        try{
            Test.setMock(HTTPCalloutMock.class, new AnimalLocatorMock());
            String result = AnimalLocator.getAnimalNameById(3);
            String expectedResult = 'chicken';
            System.assertEquals(result,expectedResult);
        }
        catch(exception e) {
            System.debug('The following exception ' + e.getMessage());
        }
        
    }
}