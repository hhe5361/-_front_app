# 2-2project_app_front
과 프로젝트 저세계 아이돌 flutter front 

#저세계 아이돌 APP Front Project
---

### dev due
2023. 9  ~ 2023. 11

### dev environment
---
framework : flutter <lang : Dart>
flutter version : 1.0.0+1
sdk: '>=3.1.0 <4.0.0'

### project goal
---
사용자가 원하는 영상(춤추는 영상 등), 사용자의 음성, 사진을 입력받고 CV generator model을 통해 사용자가 원하는 영상을 출력하는 기본적인 시스템을 가진다. 기본적으로 snow와 같은 카메라 기능의 앱을 만들어보고자 하였다.

앱의 주요 기능은 다음과 같다. 
- 카메라 기능
- 사용자로부터 영상, 사진, 음성을 입력 받고 출력으로 유튜브 영상과 사진,음성을 합성한 새로운 영상을 재생함.
- 회원가입/로그인
- 이전에 만든 영상 저장 기능

### main ui 
---
##### you can even take picture!
<img src="https://github.com/hhe5361/2-2project_app_front/assets/113621940/77871348-9c9b-452c-a77a-2e92ea6b62dd.png" width="200" height="400">

![generate](https://github.com/hhe5361/2-2project_app_front/assets/113621940/ad2a3eda-5174-4d9a-a602-9b1e5c63b65b)
![alert message](https://github.com/hhe5361/2-2project_app_front/assets/113621940/b6be60cf-e8fc-4020-801c-1dd2bf0fcb12)
![login page](https://github.com/hhe5361/2-2project_app_front/assets/113621940/4ea64c63-f329-4459-838d-1866f079611b)
![loading](https://github.com/hhe5361/2-2project_app_front/assets/113621940/9304d6b3-fc71-4a0c-9d4a-05e64ce65197)
![select your record](https://github.com/hhe5361/2-2project_app_front/assets/113621940/56dc580c-4640-444a-9b77-f0f6319b3f16)
![record](https://github.com/hhe5361/2-2project_app_front/assets/113621940/ca8cf346-ee8f-45d7-91c9-13c742dbf5d4)
![select youtube link](https://github.com/hhe5361/2-2project_app_front/assets/113621940/9e43824b-734f-4aa2-8616-1e4b4508bcb1)
![select youtube link 2](https://github.com/hhe5361/2-2project_app_front/assets/113621940/89762ead-ad1c-436d-aeaf-d959c6874791)
![upload page](https://github.com/hhe5361/2-2project_app_front/assets/113621940/45d3a38a-aa88-4898-9d7b-ef79bf6c1413)
![init page](https://github.com/hhe5361/2-2project_app_front/assets/113621940/9d6611d1-5feb-40f8-82ea-2a1d8162183e)
![select picture](https://github.com/hhe5361/2-2project_app_front/assets/113621940/6df01525-ade7-4f35-9ecf-c72a9088ad21)
![user](https://github.com/hhe5361/2-2project_app_front/assets/113621940/6d2fa8ef-4949-41b2-af1c-144b7295e7e3)


##### Select your image, record and youtube link you want to be!


### used library 
  cupertino_icons: ^1.0.2
  flutter_svg: ^2.0.9
  dio: ^5.3.3
  provider: ^6.0.5
  image_picker: ^1.0.4
  photo_manager: ^2.7.2
  youtube_player_flutter: ^8.1.2
  permission_handler: ^11.0.1
  flutter_sound: ^9.2.13
  baseflow_plugin_template: ^2.1.2
  audio_session: ^0.1.18
  gallery_saver: ^2.3.2
  camera: ^0.10.5+5
  video_player: ^2.8.1
  flutter_native_splash: ^2.3.6
  shared_preferences: ^2.2.2
