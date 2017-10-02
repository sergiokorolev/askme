
class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Serg',
            username: 'sergio',
            avatar_url: 'http://ru.playpw.com/forum/attachment.php?attachmentid=144436&d=1405139769'
        )
    ]
  end

  def new
  end

  def edit
  end

  # Это действие отзывается, когда пользователь заходит по адресу /users/:id,
  # например /users/1.
  def show
    # Болванка пользователя
    @user = User.new(
        name: 'Serg',
        username: 'sergio',
        avatar_url: 'http://ru.playpw.com/forum/attachment.php?attachmentid=144436&d=1405139769'
    )

    # Болванка вопросов для пользователя
    @questions = [
        Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.09.2017')),
        Question.new(text: 'Есть ли жизнь на Марсе?', created_at: Date.parse('27.09.2017')),
        Question.new(text: 'Как дела?', created_at: Date.parse('27.09.2017'))
    ]

    @new_question = Question.new
    # Количество вопросов
    @questions_count = @questions.count
  end
end
