# Руководство по обновлению Porosenocheck до Android SDK 36

## Обновления выполнены ✅

### 1. Android SDK и Gradle
- **compileSdkVersion**: обновлен до 36
- **targetSdkVersion**: обновлен до 36
- **minSdkVersion**: обновлен до 24 (Android 7.0)
- **Gradle**: обновлен до 8.7
- **Android Gradle Plugin**: обновлен до 8.6.0
- **Kotlin**: обновлен до 2.1.0

### 2. Java версия
- Обновлена с Java 8 до Java 17
- `sourceCompatibility`: VERSION_17
- `targetCompatibility`: VERSION_17
- `jvmTarget`: '17'

### 3. Flutter зависимости
- **Flutter SDK**: обновлен до >=3.2.0
- **Firebase Core**: ^3.3.0
- **Firebase Auth**: ^5.3.0
- **Firebase Crashlytics**: ^4.2.0
- **Firebase Analytics**: ^11.3.0
- **Firebase Messaging**: ^15.1.0
- **Flutter Local Notifications**: ^17.2.0

### 4. Версия приложения
- **Version Code**: 24
- **Version Name**: 2.0.3

### 5. Оптимизации Gradle
- Увеличена память до 4GB
- Включен параллельный сбор
- Включен кэш сборки
- Оптимизации Kotlin

### 6. Исправления совместимости
- Обновлен DialogTheme на DialogThemeData
- Исправлены API вызовы Flutterwave
- Временно отключены проблемные платежные сервисы (PayPal, PayStack)
- Обновлены deprecated API вызовы

## Что нужно сделать после обновления

### 1. Очистка проекта
```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
```

### 2. Проверка зависимостей
```bash
flutter doctor
flutter pub outdated
```

### 3. Тестирование
- Запустить приложение в debug режиме
- Проверить все основные функции
- Протестировать на разных устройствах

### 4. Возможные проблемы и решения

#### Проблема: Gradle sync fails
**Решение**: Убедитесь, что у вас установлен Java 17
```bash
java -version
```

#### Проблема: Android Studio не может найти SDK 36
**Решение**: Обновите Android SDK Tools через SDK Manager

#### Проблема: Проблемы с Firebase
**Решение**: Обновите google-services.json и agconnect-services.json

#### Проблема: Отсутствующие платежные сервисы
**Решение**: Временно отключены PayPal и PayStack. Нужно найти альтернативные решения или обновить зависимости.

### 5. Проверка совместимости
- Убедитесь, что все плагины совместимы с Android SDK 36
- Проверьте, что все native зависимости обновлены
- Протестируйте на реальных устройствах

## Полезные команды

```bash
# Очистка и пересборка
flutter clean && flutter pub get

# Проверка зависимостей
flutter pub deps

# Анализ кода
flutter analyze

# Сборка APK
flutter build apk --debug

# Сборка App Bundle
flutter build appbundle --release
```

## Следующие шаги

1. **Восстановление платежных сервисов**: Нужно найти совместимые версии PayPal и PayStack
2. **Обновление deprecated API**: Заменить все устаревшие вызовы на современные
3. **Оптимизация производительности**: Настроить ProGuard и R8 для релизных сборок
4. **Тестирование**: Полное тестирование всех функций приложения

## Контакты для поддержки
Если возникнут проблемы при обновлении, обратитесь к команде разработки.
