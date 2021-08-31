# IMQA MPM SDK 설치 가이드 

IMQA MPM 을 iOS 프로젝트에 추가하면, Objective-C 및 Swift 로 개발한 앱에서 발생하는 어플리케이션의 성능 문제를 다양한 시각으로 확인할 수 있습니다.

> **iOS SDK 문의** </br>
> 이메일 : ybcha@onycom.com

### 시스템 요구사항 

* iOS 9 이상 (권장) 
* Xcode 12 이상 

---

</br>

## 1. 프레임워크 설치 

IMQA MPM SDK는 2가지 방식으로 SDK를 설치 방법을 제공하고 있습니다. 사용하고 계신 환경에 맞춰서 설치를 진행하시면 됩니다.

### XCFrameworks 

[프레임워크 다운로드](https://github.com/onycom-imqa/IMQA-MPM-Release/releases/download/v3.1.6/IMQAMPMAgent.zip) 

위 링크를 통해 프레임워크를 다운로드 후, Targets > [Project Name] > General > Frameworks, Libraries, and Embedded Content 로 옮겨주세요.

### Cocoapods 

Podfile 에 다음과 같이 추가 후 `pod install`를 터미널에서 실행해주세요. 
```Podfile 

pod 'IMQAMPMAgent', '3.2.0'

```

위 2가지 방식 외에 원하시는 설치 방식이 있으신 경우, ybcha@onycom.com으로 문의 주시면 감사하겠습니다. 

</br>

## 2. 초기화 코드 작성하기 

자신의 프로젝트에서 사용하는 언어에 맞춰 초기화 코드를 작성해주시길 바랍니다. 

### Objective-C 

#### AppDelegate.m
```Objectivec

#import <IMQAMPMAgent/IMQAMPMAgent.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  NSString* PROJECT_KEY = @"<PROJECT_KEY>";
  IMQAConfig* mpmConfig = [[IMQAConfig alloc] init:PROJECT_KEY];
  [[IMQAMpm sharedInstance] runWithConfig:mpmConfig];
  
  return YES; 
}

```

### Swift 

#### AppDelegate.swift
```swift 

import IMQAMPMAgent

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    let PROJECT_KEY = ""
    let mpmConfig = IMQAConfig(PROJECT_KEY)
    IMQAMpm.sharedInstance.run(config: mpmConfig)
    
    return true
}
```

</br>

## 3. (선택) 설치형 고객사 수집 서버 설정

IMQA 솔루션이 기업 내 설치형 서버로 구축되어 있는 경우, 데이터를 전송하는 수집 서버 경로를 설정해주시길 바랍니다
별도로 설정이 아닌 프레임워크 내에 수집 서버를 설정되어 있는 상태를 원하시는 경우 ybcha@onycom.com으로 문의를 주시면 수집 경로를 고객사에 맞게 커스터마이징을 해서 프레임워크 파일을 전달 해 드리겠습니다. 

### Objective-C 

```Objectivec
NSString* imqaUrl = @"https://custom-url";
IMQAConfig* mpmConfig = [[IMQAConfig alloc] init:PROJECT_KEY];
mpmConfig.api_url = imqaUrl;

```

### Swift 

```swift 
let imqaUrl = "https://custom-url"

let mpmConfig = IMQAConfig(PROJECT_KEY)
mpmConfig.api_url = imqaUrl

```

</br>

## 4. WKWebView 설정

IMQA MPM 프레임워크는 WKWebView에 대해서 성능 정보도 수집하고 있습니다. UIWebView는 Apple사의 정책으로 인해 지원하고 있지 않은 점 참고 바랍니다.

### Web Server (HTML) 설정

WKWebView 데이터 수집을 원한다면 웹 페이지에 IMQA WebView JavaScript라이브러리를 삽입해 주어야 합니다. 원하는 경우 파일을 다운로드 받아 웹 페이지에서 직접 경로를 추가하여 사용 할 수 있습니다.
```html
<!-- IMQA Webview Agent 입니다. -->
<script type="text/javascript" src="https://mpm.imqa.io/static/webview/webview-agent.js" crossorigin></script>
```

### Objective-C 

```Objectivec
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
  // IMQA 설정 부분
  if([message.name isEqual: @"ImqaBridge"]) {
    [[IMQAMpm sharedInstance] saveWebviewPostMessage:self :message.body];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSURL* url = [[NSURL alloc] initWithString:@""];
  NSURLRequest* reqeust = [[NSURLRequest alloc] initWithURL:url];
  [_webView loadRequest:request];
  [_webView.configuration.userContentController addScriptMessageHandler:self name:@"ImqaBridge"];
}
```

### Swift 

```swift 
func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
  // IMQA 설정 부분
  if(message.name == "ImqaBridge") {
    IMQAMpm.sharedInstance.saveWebviewPostMessage("\(message.body)")
  }
}

override func viewDidLoad() {
  super.viewDidLoad()
  let request = URLRequest(url: URL(string: url)!) webView.load(request)
  
  // IMQA 설정 부분
  webView.configuration.userContentController.add(self, name: "ImqaBridge")
}
```

</br>

## 5. FAQ

### Error : CocoaPods could not find compatible versions for pod ""

최신 Pod Repo가 업데이트 되지 않은 문제입니다. 아래와 같이 진행해주시면 정상적으로 설치가 됩니다. 
```sh
pod install --repo-update
```

### 수집주기를 변경할 수 있나요? 

IMQA MPM 프레임워크가 데이터를 저장하는 주기와 수집하는 주기에 대해서 초 단위로 설정할 수 있습니다. (예시는 Swift로만 제공됩니다.)


```Swift
let mpmConfig = IMQAConfig("<PROJECT_KEY>")
mpmConfig.dump_interval = 10 // 성능 데이터 덤프를 뜨는 주기 (sec) 
mpmConfig.save_interval = 60 // 성능 데이터를 수집서버로 전송하는 주기 (sec)
```

### 네트워크 수집 설정을 변경할 수 있나요? 

IMQA MPM 프레임워크에서는 네트워크 수집에 대해서 수집 여부를 설정 할 수 있습니다. 또한, 특정 URL 에 대한 수집을 무시할 수 있는 기능을 제공하고 있어, 보안이 필요한 URL은 무시 할 수 있습니다. (예시는 Swift로만 제공됩니다.)

```Swift
let mpmConfig = IMQAConfig("<PROJECT_KEY>")
mpmConfig.useNetworkCollect = true // true: 수집함 , false: 수집안함 
mpmConfig.ignoreUrl = ["https://url1.com", "http://url.com"] // 특정 URL 무시 Array
```

### 수집하고 있는 데이터를 로그로 확인 할 수 있나요? 

IMQA MPM 프레임워크에서 수집하고 있는 데이터가 궁금한 경우 자체 옵션을 통해서 데이터를 Console 로 확인 하실 수 있습니다. (예시는 Swift로만 제공됩니다.)

```Swift
let mpmConfig = IMQAConfig("<PROJECT_KEY>")
mpmConfig.downloadDumpData = true
```


