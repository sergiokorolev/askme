module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'http://www.timepassfun.com/wp-content/uploads/2011/12/avatar-celebrities-13.jpg'
    end
  end

  # Определяем склонение в зависимости от числа
  def sklonenie(number, krokodil, krokodila, krokodilov)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok = number % 100

    if ostatok >= 11 && ostatok <= 14
      return krokodilov
    end

    ostatok = number % 10

    if ostatok == 1
      return krokodil
    end

    if ostatok >= 2 && ostatok <= 4
      return krokodila
    end

    if ostatok > 4 || ostatok == 0
      return krokodilov
    end
  end
end
