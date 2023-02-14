describe('Checking Dev website backend', () => {
  it('increments the visitor counter', () => {
    
      
      cy.visit(Cypress.env('DEV_DOMAIN')); 



      cy.get('[data-cy="visitorCount"]').contains(/\d+/).then(($count) =>{
          const count1 = parseInt($count.text());
          console.log(count1);
          cy.window().its('API_URL').then(url => {
              // cy.request('POST', url);
              // cy.request('GET', url).its('body').then(text => parseInt(text)).should('be.gt', count1);
              cy.request('POST', url).its('body').then(text => parseInt(text)).should('be.gt', count1);
          })

      });


  })
})