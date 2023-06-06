# Flutter Build Simple CMD 명령어 									\
												 					\
	# 옵션 변경									 					\
	make run-splash -> 				스플래시 옵션 변경 후 재설정. 			\
																	\
	# 빌드															\
	make run: 						개발 버전 빌드						\
	make run-rebuild: 				개발 버전 클린 빌드					\
	make run-prod: 					배포 버전 빌드						\
	make run-prod-rebuild: 			배포 버전 클린 빌드					\
																	\
	# 배포															\
	make create-apk-prod: 			안드로이드 prod apk 추출			\
	make create-apk-dev: 			안드로이드 dev apk 추출				\
	make create-aab-prod: 			안드로이드 prod aad 추출			\



# 스플래시 화면 및 로고 아이콘 재 설정
run-icon:
	flutter pub run flutter_launcher_icons:main
	flutter pub run flutter_native_splash:remove
	flutter pub run flutter_native_splash:create

# DebugDev Run
run:
	flutter run --debug --no-sound-null-safety -t lib/app/env/dev.dart

# DebugDev Rebuild
run-rebuild:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter pub run build_runner build --delete-conflicting-outputs
	flutter run --debug --no-sound-null-safety -t lib/app/env/dev.dart

# ProdRelease Run
run-prod:
	flutter run --release --no-sound-null-safety -t lib/app/env/prod.dart

# ProdRelease Rebuild
run-prod-rebuild:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter pub run build_runner build --delete-conflicting-outputs
	flutter run --release --no-sound-null-safety -t lib/app/env/prod.dart


########################
##### Distribution #####
########################

# android apk-release create
create-apk-prod:
	flutter build apk --release --no-tree-shake-icons --no-sound-null-safety -t lib/app/env/prod.dart

# android apk-debug create
create-apk-dev:
	flutter build apk --debug --no-tree-shake-icons --no-sound-null-safety -t lib/app/env/dev.dart

# android aab-prod create
create-aab-prod:
	flutter build appbundle --release --no-tree-shake-icons --no-sound-null-safety -t lib/app/env/prod.dart


