describe('test local demo page', () => {
  it('will fail', () => {
    assert.fail('forced failure')
  })
  it('heading', () => {
    cy.visit('index.html')
    cy.contains('h2', 'Test')
  })
})
