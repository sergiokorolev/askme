
class UsersController < ApplicationController
  # Загружаем юзера из базы для экшенов кроме :index, :create, :new
  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.all
  end

  # Действие new будет отзываться по адресу /users/new
  def new
    # Если пользователь уже авторизован, ему не нужна новая учетная запись,
    # отправляем его на главную с сообщением.
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    # Иначе, создаем болванку нового пользователя.
    @user = User.new
  end

  # Действие create будет отзываться при POST-запросе по адресу /users из формы
  # нового пользователя, которая находится в шаблоне на странице /users/new.
  def create
    # Если пользователь уже авторизован, ему не нужна новая учетная запись,
    # отправляем его на главную с сообщением.
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    # Иначе, создаем нового пользователя с параметрами, которые нам предоставит
    # метод user_params.
    @user = User.new(user_params)

    # Пытаемся сохранить пользователя.
    if @user.save
      # Если удалось, отправляем пользователя на главную с сообщение, что
      # пользователь создан.
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
    else
      # Если не удалось по какой-то причине сохранить пользователя, то рисуем
      # (обратите внимание, это не редирект), страницу new с формой
      # пользователя, который у нас лежит в переменной @user. В этом объекте
      # содержатся ошибки валидации, которые выведет шаблон формы.
      render 'new'
    end
  end

  def edit
  end

  # Это действие отзывается, когда пользователь заходит по адресу /users/:id,
  # например /users/1
  #
  # Перед этим действием сработает before_action :load_user и в переменной @user
  # у нас будет лежать пользовать с нужным id равным params[:id].
  def show
    # Достаем вопросы пользователя с помощью метода questions, который мы
    # объявили в модели User (has_many :questions), у результата возврата этого
    # метода вызываем метод order, который отсортирует вопросы по дате.
    @questions = @user.questions.order(created_at: :desc)

    # Для формы нового вопроса, которая есть у нас на странице пользователя,
    # создаем болванку вопроса, вызывая метод build у результата вызова метода
    # @user.questions.
    @new_question = @user.questions.build
    # Количество вопросов
    @questions_count = @questions.count
  end

  private
  # Если загруженный из базы юзер и текущий залогиненный не совпадают — посылаем
  # его с помощью описанного в контроллере ApplicationController метода
  # reject_user.
  def authorize_user
    reject_user unless @user == current_user
  end

  # Загружаем из базы запрошенного юзера, находя его по params[:id].
  def load_user
    @user ||= User.find params[:id]
  end

  # Явно задаем список разрешенных параметров для модели User. Мы говорим, что
  # у хэша params должен быть ключ :user. Значением этого ключа может быть хэш с
  # ключами: :email, :password, :password_confirmation, :name, :username и
  # :avatar_url. Другие ключи будут отброшены.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
