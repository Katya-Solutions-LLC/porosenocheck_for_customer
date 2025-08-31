# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Google Play Core rules
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Razorpay rules
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}

# Stripe rules
-dontwarn com.stripe.android.**
-keep class com.stripe.android.** {*;}

# PhonePe rules
-dontwarn com.phonepe.**
-keep class com.phonepe.** {*;}

# Payment callback methods
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# General optimization rules
-optimizations !method/inlining/
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes Signature
-keepattributes Exceptions

# Java 17 compatibility
-keep class java.util.concurrent.** { *; }
-keep class java.util.** { *; }

# Remove obsolete warnings
-dontwarn java.lang.instrument.ClassFileTransformer
-dontwarn java.lang.instrument.Instrumentation

# R8 specific rules
-keep class * implements com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class * extends com.google.android.play.core.splitcompat.SplitCompatApplication { *; }