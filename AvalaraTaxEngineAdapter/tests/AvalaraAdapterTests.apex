@isTest
public class AvalaraAdapterTests{

    public static testmethod void testCalculateTaxSuccess() {
        Double d = 1.0;
        commercetax.TaxAddressRequest add = new commercetax.TaxAddressRequest('city','country',d,d,'postCode','state','street','locationCode');
        commercetax.HeaderTaxAddressesRequest addresses = new commercetax.HeaderTaxAddressesRequest(add, add, add, add, add);
        commercetax.TaxCustomerDetailsRequest customer = new commercetax.TaxCustomerDetailsRequest('',code','exemptionNo','exemptionReason');
        
        commercetax.LineTaxAddressesRequest lineAddresses = new commercetax.LineTaxAddressesRequest(add, add, add, add, add);
        commercetax.TaxLineItemRequest taxLineItem = new commercetax.TaxLineItemRequest(lineAddresses, d, 'description', 'productCode', d, 'lineNumber', 'taxCode',system.today());
        List<commercetax.TaxLineItemRequest> listOfItems = new List<commercetax.TaxLineItemRequest>();
        listOfItems.add(taxLineItem);

        commercetax.CalculateTaxRequest calculateTaxRequest = new commercetax.CalculateTaxRequest(commercetax.CalculateTaxType.Actual);
        calculateTaxRequest.taxTransactionType = commercetax.TaxTransactionType.Debit;
        calculateTaxRequest.isCommit = true;
        calculateTaxRequest.addresses = addresses;
        calculateTaxRequest.currencyisocode = 'USD';
        calculateTaxRequest.customerdetails = customer;
        calculateTaxRequest.Description = 'Description';
        calculateTaxRequest.DocumentCode = 'DocumentCode';
        calculateTaxRequest.effectiveDate = system.now();
        calculateTaxREquest.ReferenceEntityId = 'ReferenceEntityId';
        CalculateTaxRequest.lineItems = listOfItems;
        
        commercetax.TaxEngineContext taxEngineContext = new commercetax.TaxEngineContext(calculateTaxRequest, commercetax.RequestType.CalculateTax, 'https://sandbox-rest.avatax.com/api/v2');
        
        AvalaraAdapter avalaraAd = new AvalaraAdapter();
        commercetax.CalculateTaxResponse response = (commercetax.CalculateTaxResponse)avalaraAd.processRequest(taxEngineContext);
    }
}