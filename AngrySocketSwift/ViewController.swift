//
//  ViewController.swift
//  AngrySocketSwift
//
//  Created by active on 2021/08/05.
//

import UIKit
import SwiftSocket// 오오오오오 드디어


var SocketGateWay = TCPClient(address: "", port: 0)


extension StringProtocol {
    var data: Data { .init(utf8) }
    var bytes: [UInt8] { .init(utf8) }
}

class ViewController: UIViewController {
    @IBOutlet weak var showLabel: UILabel!
    let NET_RECEIVE_SIZE_HEAD = 8;
    
    var ProtocalType : Int = 0;
    var getRealText : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(UnicodeScalar(40)))
        
        
        SocketGateWay = TCPClient(address: "211.119.65.7", port: 32559)
        
//        SocketGateWay.address = "211.119.65.7"
//        SocketGateWay.port =  32559
  
        print(AES256Util.decrypt(encoded: "UWzX6ic67YXJj3ZHja+WPPrB39TnxiU+SN4eke5tn74="))
       // print(AES256Util.decrypt(encoded: "B83tJzi2S8EMz45vdrvZS1ECv141QdLuDHAdy21udjY="))
        
        print(AES256Util.decrypt(encoded: "\0\0\u{fffd}%\0\0\04AkKT3Z4DgJvbsM2BeTnXMRRwzIlc14cTV7c+xlqJ8X4="))
       // let testArray = getRealDataArray(DataString: "J2021091014494628300000")
        
        var ok : UInt16 = NSString(string: "*bc").character(at: 0)
        print(ok)
       // timeShower()
        var test4 = "<stopmaster*1(.iosp1CA3621A-79C9-4F59-93D0-BEF4EA33AAE04x86_64,en"
     ComboDatasendTcp(stringData: test4, sendlogicType: 32050)
        ComboDatasendTcp(stringData: test4, sendlogicType: 32050)
      //  print( array )
    }
  
    func timeShower(){
//        var form = DateFormatter.init()
//        form.dateFormat = "yyyyMMddHHmmssSSS"
//        print(form.string(from: Date.now))
    }
    @IBAction func TCPButClick(_ sender: Any) {
      //  showLabel.text = "ll"
      //  pleaseConnectTCP()// 이게 원본
        var test1 = "J20210810101514536.ios60.92.22("
        var test2 =  "DDZb+/LnNU93/+yWCevC4uxXEuH42DNskiDcUQQCC9U="//mO1pveGwRm1vOZvkjO45ve48KZVBN9xCHddPGDpyzs0="//
        var test3 = "8w_marin2*1(.iospA3C3F4B8-6184-4C28-8F8F-3F528AAFAFC14x86_64,ko"//"J20210908091008021.ios60.92.27("//나도 이제 글씨 보낼수있는거야?
        var test9 = "CfDfVrsBqHLSiPP2EZ2pB3jEr1+QZkDXkHy6yIo4SHw1Ojk6VtE8wnzKZXUQ+qNBczmbnxJGLH/QxD7Ef/qpvFOQv5+V2FqJmf4cRZBp8N529G+NFdSk2f/mwKySOgFxxuvKBGvqDGL39YIol1OeTA=="
        var test4 = "<stopmaster*1(.iosp1CA3621A-79C9-4F59-93D0-BEF4EA33AAE04x86_64,en"
        
        let test = AES256Util.decrypt(encoded: test9)
        
        //pleaseConnectTCPWhat(stringData: AES256Util.encrypt(string: test3))
        
        
//        pleaseConnectTCPWhat(stringData: test2)//원본

        //testServerMobile()
        sendPackettoServer(sendMessage: test4)
        
        print("==============================================")
      //  specialDatasendTcp(ip: "211.119.65.7", port: 32559, stringData:  "J20211117105354814.ios60.92.27(", sendlogicType: 32300)
//        specialDatasendTcp(ip: "211.119.65.7", port: 32563, stringData:  "6rpadminH3170162645052937", sendlogicType: 33010)
        specialDatasendTcp(ip: "211.119.65.7", port: 32563, stringData:  "6rpadminH3170162646906977*1", sendlogicType: 33060)
        print("===================end========================")
    }
    func sendPackettoServer(sendMessage : String){
        let sendPackage = AES256Util.encrypt(string: sendMessage)
        pleaseConnectTCPWhat(stringData: sendPackage)
    }


    func pleaseConnectTCPWhat(stringData : String){
        let addr = "211.119.65.7"//"mobile.activepost.co.kr"
        let port =  32559//12559
        let encryptString : String = stringData
        let logicType : Int32 = 32050// 32300
        let client : TCPClient = TCPClient(address: addr, port: Int32(port))
        let result : Result = client.connect(timeout: 7)
        if(result.isSuccess){
            let totalSize : Int32 = Int32( strlen(encryptString)+8)
            var array = withUnsafeBytes(of: logicType.bigEndian, Array.init)
            var d : Data = Data.init()
            d.append(contentsOf: array)

            array = withUnsafeBytes(of: totalSize.bigEndian, Array.init)
            d.append(contentsOf: array)
            d.append(contentsOf:encryptString.bytes)
            
            let data = client.send(data:d )//

            if(data.isSuccess){
                let getData = client.read(1024*1024)// 지금 여기서 null이 뜸 이게 왜이걸로 되어있었지? 1024*1024
                if let a = getData {// getData 가 null인지 확인 ()쓰면 안됨
//                    let str1 = String(bytes: a, encoding: String.Encoding.utf8)
//                    let k = String(decoding: a, as: UTF8.self)
                    let getStr = String(decoding: a, as: UTF8.self)
                    
                    if (getStr.count>0) {//utf8//let str = String(decoding: a, as: UTF8.self)
                        print(getStr)
                        
                        let editor = String(getStr.suffix(getStr.count-NET_RECEIVE_SIZE_HEAD))// 44글자짜르는 함수
                        print(AES256Util.decrypt(encoded: editor))//-> 이값이랑
                      
                        // 앞의 8자리로 만드는 protocal type
                        let tests = Data(buffer: UnsafeBufferPointer(start: a, count: a.count))//타입을 잘못만들었다 -> 지못미
                     
                        print(byteToInt(getData: tests))// -> 지금 이값이 중요함
                        //잉? 0나오는 데
                        ProtocalType = byteToInt(getData: tests)
                        getRealText = AES256Util.decrypt(encoded: editor)
                        showLabel.text = String(ProtocalType) + " : " + getRealText
                        let DataArray = getRealDataArray(DataString: getRealText)
                        
                    }else{
                        print("인코딩 실패")
                    }
                }else{
                    print("받아온 값이 없음")// ->일단 순간 붙긴 했다는 것같은데
                }
            }else{
                print(data.error)
            }
        }else if(result.isFailure){
            print(result.error)
        }
        client.close()
    }
    
    func specialDatasendTcp(ip : String, port : Int, stringData : String , sendlogicType :Int32 ){//보낼데이터 ,로직타입
        //암호화 안된걸로 넣어야 함-> SendData 를 넣으면 될듯
        let addr = ip
        let port = port
        let encryptString : String = AES256Util.encrypt(string: stringData)//암호화
        let logicType : Int32 = sendlogicType//32000
        let client : TCPClient = TCPClient(address: addr, port: Int32(port))
        let result : Result = client.connect(timeout: 1)
        if(result.isSuccess){
            let totalSize : Int32 = Int32( strlen(encryptString)+8)
            var array = withUnsafeBytes(of: logicType.bigEndian, Array.init)
            var d : Data = Data.init()
            d.append(contentsOf: array)
            array = withUnsafeBytes(of: totalSize.bigEndian, Array.init)
            d.append(contentsOf: array)
            d.append(contentsOf:encryptString.bytes)
            let data = client.send(data:d )//
            if(data.isSuccess){
//                let getData = client.read(1024*1024)// 지금 여기서 null이 뜸 이게 왜이걸로 되어있었지? 1024*1024
                //그래 뭐 터지기야 하겠냐
                var getData : [UInt8]?
                while true {
                    guard let response = client.read(1024*1024, timeout: 1) else {break}
                    if (getData != nil) {
                        getData?.append(contentsOf: response)
                    }else{
                        getData = response
                    }
                }
              //  let getData = client.read(1024*1024, timeout: 10)
                
                if let byteData = getData {// getData 가 null인지 확인 ()쓰면 안됨-> 일단 있는지만 확인
                    let str = String(decoding: byteData, as: UTF8.self)// nil 좀 뜨지마라
                    if (str.count > 0){//utf8
                        let editor = String(str.suffix(str.count-NET_RECEIVE_SIZE_HEAD))// 44글자짜르는 함수
                      
                    }else{
                        print("인코딩 실패")
                    }
                }else{// 이부분에대한 대응이 필요할듯?
                    print("받아온 값이 없음")// ->일단 순간 붙긴 했다는 것같은데
               
                }
            }else{
                print(data.error)
            }
        }else if(result.isFailure){
            print(result.error)
        }
        client.close()
    }
    
    /////////////////////////////////////////////////////
    ///이걸 고친후에 뒤로 가야 할듯 ///////////////
    /////////////////////////////////////////////////////
    func ComboDatasendTcp(stringData : String , sendlogicType :Int32 ){//보낼데이터 ,로직타입 + 커넥트 끊어지는 거 막긴 해야할듯?
        //암호화 안된걸로 넣어야 함-> SendData 를 넣으면 될듯
     
        let encryptString : String = AES256Util.encrypt(string: stringData)//암호화
        let logicType : Int32 = sendlogicType//32000
        //SocketGateWay = TCPClient(address: addr, port: Int32(port))
        let result : Result = SocketGateWay.connect(timeout: 1)
        if(result.isSuccess){
            let totalSize : Int32 = Int32( strlen(encryptString)+8)
            var array = withUnsafeBytes(of: logicType.bigEndian, Array.init)
            var d : Data = Data.init()
            d.append(contentsOf: array)
            array = withUnsafeBytes(of: totalSize.bigEndian, Array.init)
            d.append(contentsOf: array)
            d.append(contentsOf:encryptString.bytes)
            let data = SocketGateWay.send(data:d )//
            if(data.isSuccess){
//                let getData = client.read(1024*1024)// 지금 여기서 null이 뜸 이게 왜이걸로 되어있었지? 1024*1024
                //그래 뭐 터지기야 하겠냐
                var getData : [UInt8]?
                while true {
                    guard let response = SocketGateWay.read(1024*1024, timeout: 1) else {break}
                    if (getData != nil) {
                        getData?.append(contentsOf: response)
                    }else{
                        getData = response
                    }
                }
              //  let getData = client.read(1024*1024, timeout: 10)
                
                if let byteData = getData {// getData 가 null인지 확인 ()쓰면 안됨-> 일단 있는지만 확인
                    let str = String(decoding: byteData, as: UTF8.self)// nil 좀 뜨지마라
                    if (str.count > 0){//utf8
                        let editor = String(str.suffix(str.count-NET_RECEIVE_SIZE_HEAD))// 44글자짜르는 함수
                      
                    }else{
                        print("인코딩 실패")
                    }
                }else{// 이부분에대한 대응이 필요할듯?
                    print("받아온 값이 없음")// ->일단 순간 붙긴 했다는 것같은데
               
                }
            }else{
                print(data.error)
            }
        }else if(result.isFailure){
            print(result.error)
        }
//        client.close()-> 애때매 지금 살짝곤란한데
    }
    
    
    
    
    
    func pleaseConnectTCP(){
        let addr = "mobile.activepost.co.kr"
        let port = 12559
        let encryptString : String = "mO1pveGwRm1vOZvkjO45ve48KZVBN9xCHddPGDpyzs0="
        print(AES256Util.decrypt(encoded: encryptString))
        let logicType : Int32 = 32300
        
        let client : TCPClient = TCPClient(address: addr, port: Int32(port))
        
        let result : Result = client.connect(timeout: 7)
        if(result.isSuccess){
            let totalSize : Int32 = Int32( strlen(encryptString)+8)
            
//            var bufferSendData : Array<Character> = Array<Character>(repeating: "\0", count: totalSize)
//            bufferSendData[0] = logicType>>24
//            bufferSendData[0] = Character(UnicodeScalar(logicType>>24))
//
//
//            bufferSendData[1] = Character(logicType>>16)
//            bufferSendData[2] = Character(logicType>>8)
//            bufferSendData[3] = Character(logicType)
//            bufferSendData[4] = Character(totalSize>>24)
//            bufferSendData[5] = Character(totalSize>>16)
//            bufferSendData[6] = Character(totalSize>>8)
//
//            bufferSendData[7] = Character(totalSize)
            
            var array = withUnsafeBytes(of: logicType.bigEndian, Array.init)
            
            var d : Data = Data.init()
            d.append(contentsOf: array)

            array = withUnsafeBytes(of: totalSize.bigEndian, Array.init)
            d.append(contentsOf: array)
//            string.append(Character(UnicodeScalar(logicType >> 24)!))
//            string.append(Character(UnicodeScalar(logicType >> 16)!))
//            string.append(Character(UnicodeScalar(logicType >> 8)!))
//            string.append(Character(UnicodeScalar(logicType)!))//-> 진짜 애만 값이 다르다?
//            string.append(String(totalSize >> 24))
//            string.append(String(totalSize >> 16))
//            string.append(String(totalSize >> 8))
//            string.append(String(totalSize))
        
            d.append(contentsOf:encryptString.bytes)
            
            let data = client.send(data:d )//"Hello_swift_test")// 이게 아니라 딴걸 보내긴 해야할것같지만;
            // mO1pveGwRm1vOZvkjO45ve48KZVBN9xCHddPGDpyzs0=
//            var sample : Data
            //단순 복사로는 안되는듯-> 아니
            if(data.isSuccess){
                let getData = client.read(1024*1024)// 지금 여기서 null이 뜸
                if let a = getData {// getData 가 null인지 확인 ()쓰면 안됨
                    if let str = String(bytes: a, encoding: String.Encoding.utf8){
                        print(str)
                        print(str.count)
                    }
                }else{
                    print("받아온 값이 없음")// ->일단 순간 붙긴 했다는 것같은데
                }
            }else{
                print(data.error)
                
            }
        }else if(result.isFailure){
            print(result.error)
           
        }else{
            
        }
        
        client.close()
    }
    
 
    func byteToInt(getData : Data) -> Int {//이게 지금 리틀 에디언 개념인것같은데
        var result : Int = 0;
        result += (Int(getData[0]) & 0xFF) << 24
        result += (Int(getData[1]) & 0xFF) << 16
        result += (Int(getData[2]) & 0xFF) << 8
        result += (Int(getData[3]) & 0xFF)
                                                
//        var array = withUnsafeBytes(of: logicType.bigEndian, Array.init)
//        이게 통하네 (하긴 비슷한 구조니까)
        return result
    }
    
    func getRawData(RawData : String){// 자릿수 프리데이터 뭉치
        let dataSize = RawData.count
        
        
        
    }
    func getRealDataArray(DataString : String)-> [String]{
        var ArrayResult : [String] = []
        let totalDataStringSize = DataString.count
        var currentOffset = 0
        
        NSString(string: DataString).character(at: currentOffset)
        while (currentOffset < totalDataStringSize) {
            var partSize = ( Int( NSString(string: DataString).character(at: currentOffset))-40) / 2
            //17 이 나올것
            if(partSize < 0){
                break
            }
            currentOffset+=1
            
            if(partSize == 0){
                //??? - 여기 안넣어도 될듯?
//                [ receivedData addObject:partData ];
//                partData = nil;
//                partData = [ [ NSMutableString alloc ] init ];
            }else if(partSize >= ( 65494 - 40 ) / 2){// 뭔지는 모르겠지만 NETWORD_DATA_MAX_SIZE
                let errorRange = NSRange(location: currentOffset, length: totalDataStringSize-currentOffset+1)
                if let lastRange = Range(errorRange, in: DataString){
                    let last = DataString[lastRange]
                    ArrayResult.append(String(last))// 이렇게 쓰는건 되나 보네
                }
                
            }else{
                
//                let word = DataString[NSRange(location: 0, length: 8)]
                let cutRange = NSRange(location: currentOffset, length: partSize)
                if let cutRange = Range(cutRange,in: DataString){//이런 형식의 문법은 익숙해져야겠는걸
                    print(DataString[cutRange])// 이렇게 쓰라고?
                    let cutData = DataString[cutRange]
                    ArrayResult.append(String(cutData))// 이렇게 쓰는건 되나 보네
                }
                //swift4 에서는 이렇게 쓴다는데 5는 안통하는듯
                // 이제 여기서 데이터를 짤라서 배열에 넣는다
//                NSRange range = { static_cast<NSUInteger>( currentOffset ), static_cast<NSUInteger>( partSize ) };
//                [ partData appendString:[ text substringWithRange:range    ] ];
//                [ receivedData addObject:partData ];
//
//                partData = nil;
//                partData = [ [ NSMutableString alloc ] init ];
            }
            currentOffset += partSize
            if(currentOffset >= totalDataStringSize)
            {
                break
            }
        }
        
        return ArrayResult
    }

//    + (int)byteToInt:(unsigned char*)b// 또냐
//    {
//        int result = 0;
//
//        result += ( ( b[ 0 ] & 0xFF ) << 24 );
//        result += ( ( b[ 1 ] & 0xFF ) << 16 );
//        result += ( ( b[ 2 ] & 0xFF ) << 8 );
//        result += ( ( b[ 3 ] & 0xFF ) );
//
//        return result;
//    }
    
    
    
    
    
    func ExampleCode()  {
        let client = TCPClient(address: "www.apple.com", port: 80)
        switch client.connect(timeout: 1) {
          case .success:
            switch client.send(string: "GET / HTTP/1.0\n\n" ) {
              case .success:
                guard let data = client.read(1024*10) else { return }

                if let response = String(bytes: data, encoding: .utf8) {
                  print(response)
                }
              case .failure(let error):
                print(error)
            }
          case .failure(let error):
            print(error)
        }
    }
  
// 이 아래는 서버용 이란다 ->
    func echoService(client: TCPClient) {
        print("Newclient from:\(client.address)[\(client.port)]")
        var d = client.read(1024*10)
        client.send(data: d!)
        client.close()
    }

    func testServer() {
        let server = TCPServer(address: "127.0.0.1", port: 8080)
        switch server.listen() {
          case .success:
            while true {
                if var client = server.accept() {
                    echoService(client: client)
                } else {
                    print("accept error")
                }
            }
          case .failure(let error):
            print(error)
        }
    }
    
    func testServerMobile() {
        let addr = "mobile.activepost.co.kr"
        
        let server = TCPServer(address: addr, port: 12559)
        
        switch server.listen() {
          case .success:
            while true {
                if var client = server.accept() {
                    echoService(client: client)
                } else {
                    print("accept error")
                }
            }
          case .failure(let error):
            print(error)
        }
    }

}

//=========================================================      // Do any additional setup after loading the view.
//        pleaseConnectTCP()
        
//        var test = ","
//        print(UnicodeScalar(test)?.value)
//        print(UnicodeScalar(170))
        
//        var test1 = "J20210810101514536.ios60.92.22("
//        var test2 = "mO1pveGwRm1vOZvkjO45ve48KZVBN9xCHddPGDpyzs0="
//        var test3 = "J20210810104902228.ios60.92.22("
//        var test4 = "9qz+IphicG0wNM/kD3Fm+/OVFZS6E6SE4mRiYlstKVk="
//
//        print(AES256Util.encrypt(string: test1))
//        print(AES256Util.decrypt(encoded: test2))
