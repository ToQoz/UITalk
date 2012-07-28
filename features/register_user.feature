Feature: ユーザー登録

  ユーザー登録ができる。
  必要なデータが足りていれば登録後ログインし、
  足りてなければエラーを表示する。

  Scenario: twitterでログインしてメールアドレスを追加してsubmitすると、ユーザーが登録されログイン状態になる。
    When I visit "/" page
    And I click "signin" link
    And I fill in "user_email" field with "toqoz403@gmail.com"
    And I click "Create User" button
    Then I should see succeed signin messages

  Scenario: twitterでログインしてメールアドレスを空のままsubmitすると、エラーが表示される。
    When I visit "/" page
    And I click "signin" link
    And I click "Create User" button
    Then I should see error with email messages
