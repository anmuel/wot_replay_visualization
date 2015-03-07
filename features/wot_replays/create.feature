Feature: Uploading a World of Tanks Replay File to the application

Background:
  Given I open the "new" page of the "Wot Replay" resource

Scenario: Uploading a valid wotreplay-file
  When I upload the file "20140622_0021_germany-RhB_Waffentrager_10_hills.wotreplay"
  Then I should be redirected to the "index" page of the "Wot Replay" resource
  And I should see a success message
  And I see the uploaded replay's data in the table
