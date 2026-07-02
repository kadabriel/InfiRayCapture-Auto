# IrProCapture på denne Mac-en

Prosjektet er klart her:

```sh
~/Documents/GitHub/InfiRayCapture
```

Du skal ikke åpne `.swift`-filene direkte. De er bare kildekodefiler. Åpne dette i Xcode:

```sh
~/Documents/GitHub/InfiRayCapture/IrProCapture.xcodeproj
```

## Bygg og kjør

Prosjektet trenger full Xcode.app. Hvis Xcode er installert, kan du bygge appen med:

```sh
cd ~/Documents/GitHub/InfiRayCapture
./build-local.sh
```

Hvis Xcode spør om lisens første gang, kjør:

```sh
sudo xcodebuild -license accept
```

Når byggingen er ferdig, ligger appen her:

```sh
~/Documents/GitHub/InfiRayCapture/build/IrProCapture.app
```

Start den med:

```sh
open ~/Documents/GitHub/InfiRayCapture/build/IrProCapture.app
```

## Bruk

1. Koble InfiRay P2Pro USB-C-kameraet til Mac-en.
2. Start `IrProCapture`.
3. Gi kameratilgang hvis macOS spør.
4. Trykk `Start Camera`.
5. Temperatur-range er automatisk som standard. Åpne range-panelet og huk av `Automatic Range` hvis du tidligere har brukt manuell range.

Hvis kameraet ikke dukker opp, test først at macOS ser det som kamera i FaceTime, Photo Booth eller en annen kamera-app.
