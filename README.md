**AnyChat**
-----------------

## **About App**
Anonymous multiplatform chat application written in Flutter

## **Structure**
Application utilizes principle of **Clean Architecture**,
using **Riverpod** library as a state management tool (*notifier* is used as a *view-model*).
The dependency graph is built manually with *Provider*.

* **Feature** folder contains implementation of ***screens*** used in app (chat screen).
* **Domain** folder contains abstractions and models that are used by ***view-models*** (*notifiers* from *Riverpod*)
* **Data** folder contains ***implementations of abstractions*** and special libraries (***Dio http client***)

## **Preview**

[Full showcase](https://rutube.ru/video/private/3c009757c55e3af2d5922bee2014494d/?p=AOVyBhl9BNE3PccsgPIRuQ)

![Preview](assets/preview.png)

## **Stack**

<ul>
    <li>Dart 3.5.1</li>
    <li>Flutter 3.18.0</li>
    <li>Dio</li>
    <li>Riverpod</li>
    <li>FPDart</li>
    <li>L10N (Localization)</li>
</ul>

## **License**
*GNU Public License V 3.0*
