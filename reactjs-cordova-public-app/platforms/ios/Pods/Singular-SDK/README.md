# Singular-iOS-SDK

To get the instructions on how to integrate Singular iOS SDK please visit the following page [iOS SDK](https://support.singular.net/hc/en-us/articles/360037950591)

## Swift Package Manager
### Introduction
Singular SDK version 10.4.1 supports installation via Swift Package Manager.

### Installation
**Step 1.** In Xcode go to: File -> Swift Packages -> Add Package Dependency...

<img width="683" alt="Screenshot 2021-06-08 at 4 38 30 PM" src="https://user-images.githubusercontent.com/72547023/121176544-f4e24680-c879-11eb-9de1-35e9843d95aa.png">

**Step 2.** Enter the Singular SDK GitHub repository - ```https://github.com/singular-labs/Singular-iOS-SDK```

<img width="727" alt="Screenshot 2021-06-08 at 4 39 06 PM" src="https://user-images.githubusercontent.com/72547023/121176117-79809500-c879-11eb-8676-31ad12875be9.png">

**Step 3.** Select the Singular SDK version

<img width="728" alt="Screenshot 2021-06-08 at 4 39 25 PM" src="https://user-images.githubusercontent.com/72547023/121176131-7edddf80-c879-11eb-9fee-04281efa50d6.png">

**Step 4.** Select the Singular library

<img width="715" alt="Screenshot 2021-06-08 at 4 39 37 PM" src="https://user-images.githubusercontent.com/72547023/121176159-869d8400-c879-11eb-89b1-283c1afd78af.png">

**Step 5.** Add the following libraries. ```AdServices.framework``` (Must be added, but mark it as Optional since it's only available for devices with iOS 14.3 and higher).

<img width="741" alt="Screenshot 2021-06-08 at 5 27 44 PM" src="https://user-images.githubusercontent.com/72547023/121180811-e185aa00-c87e-11eb-8342-75fa7df3fa05.png">

**Step 6.**  In your ```AppDelegate``` file import Singular module and start using Singular SDK

<img width="1127" alt="Screenshot 2021-06-08 at 4 40 41 PM" src="https://user-images.githubusercontent.com/72547023/121176268-a5037f80-c879-11eb-9d8d-846d5738705d.png">
