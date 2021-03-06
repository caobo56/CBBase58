# CBBase58
从 CoreBitcoin 项目摘出来的base58部分代码，可以直接引用Base58 

创建该repo 是因为公司区块链项目需要用到base58，但在pod和github上又没找到合适的库

于是自己创建一个，方便项目集成

其实 CoreBitcoin项目中有其他与区块链相关的更为完整的pod库

但我不需要那么多，万一其他类别的项目也用到了base58，可以简单的集成CBBase58就可以了

### CoreBitcoin项目地址
https://github.com/oleganza/CoreBitcoin

### 使用方法
```
pod 'CBBase58'
```

### 代码使用方法

#### 1) 先导入必要的头文件

```
#import "NS+BTCBase58.h"
```

#### 2) 根据类型进行base58转换 

NS+BTCBase58 支持 NSString、NSData、NSMutableData，这里仅给出NSString、NSData的。

```
    NSString * tt = @"ttttt";
    NSLog(@"dataFromBase58 = %@\n dataFromBase58Check = %@",[tt dataFromBase58],[tt dataFromBase58Check]);
    
    NSData * ttdata = [tt dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"base58String = %@\n dataFromBase58Check = %@",[ttdata base58String],[tt dataFromBase58Check]);
```


### base58的查询字母表

我的CBBase58 是从CoreBitcoin摘出来的，CoreBitcoin是比特币的pod库，他的base58 最后查询的字母表与比特币的保持一致，如果有更改的需要，可以从github上下载代码并修改。

修改代码的位置为：
BTCBase58.m  
```
static const char* BTCBase58Alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
```

# 关于base58
base58和base64一样是一种二进制转可视字符串的算法，主要用来转换大整数值。区别是，转换出来的字符串，去除了几个看起来会产生歧义的字符，如 0 (零), O (大写字母O), I (大写的字母i) and l (小写的字母L) ，和几个影响双击选择的字符，如/, +。结果字符集正好58个字符(包括9个数字，24个大写字母，25个小写字母)。不同的应用实现中，base58 最后查询的字母表可能不同，所以没有具体的标准。

比特币之所以加入改进版的 Base58 算法，主要为了解决 Base58 导出的字符串没有校验机制，这样，在传播过程中，如果漏写了几个字符，会检测不出来。所以使用了改进版的算法 Base58Check。

下面是几个应用中的字母表:

比特币地址
```
123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz
```
Monero 地址
```
123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz
```
Ripple 地址
```
rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz
```
Flickr 的短URL
```
123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ
```

# 关于RIPEMD-160(CBBase58 版本 0.9.1 发布)
RIPEMD（RACE Integrity Primitives Evaluation Message Digest，RACE原始完整性校验消息摘要），是Hans Dobbertin等3人在md4,md5的基础上，于1996年提出来的。算法共有4个标准128、160、256和320，其对应输出长度分别为16字节、20字节、32字节和40字节。不过，让人难以致信的是RIPEMD的设计者们根本就没有真正设计256和320位这2种标准，他们只是在128位和160位的基础上，修改了初始参数和s-box来达到输出为256和320位的目的。所以，256位的强度和128相当，而320位的强度和160位相当。RIPEMD建立在md的基础之上，所以，其添加数据的方式和md5完全一样。

在比特币区块链中，生成地址的过程用到了RIPEMD-160的算法，CoreBitcoin中同样也集成了相关的算法，（其实现也是基于OpenSSL）。

于是在CBBase58 的版本 0.9.1中，我将RIPEMD-160的相关类 NSData+Hashing.h/NSData+Hashing.m 也集成到pod库中，以方便使用。

NSData+Hashing.h 的接口：
```
#import <Foundation/Foundation.h>

@interface NSData (Hashing)

/// Returns the SHA-256 hash of self.
- (NSData *)SHA256Hash;

/// Returns the RIPEMD-160 hash of self.
- (NSData *)RIPEMD160Hash;

/// Performs the HMAC512-SHA256 algorithm on self using key and stores the result in digest.
- (void)HMACSHA512WithKey:(NSData *)key digest:(NSMutableData *)digest;

@end

```

# CB_RIPEMD

项目地址：
https://github.com/caobo56/CB_RIPEMD

### 使用方式：
```
pod  'CB_RIPEMD'
```
目前版本为（0.9.0）

CB_RIPEMD是RIPEMD算法的OC基础pod库，目前只有RIPEMD-160。

也是从CoreBitcoin 项目摘出来的，目的是方便查找RIPEMD-160(RIPEMD160)。

我之前的CBBase58也有这部分代码，但单独放出来方便查找。

目前该 repo 只有 RIPEMD-160。

计划是将 RIPEMD 下的相关算法都集成一下，包括（128、160、256和320），回头慢慢补充更新。

# 关于 BCGenerator

BCGenerator 我自己拼装的一个根据种子生成私钥，公钥，地址的pod库。
CBBase58的pod库也是为了这个pod库封装的，但后来发现不必要了，就都直接使用 BCGenerator 了。
其中，BCGenerator 中使用Base58 是在 generator.address 这一步中，具体情况，可以移步看一下相关代码。

项目地址:https://github.com/caobo56/BCGenerator

使用方法如下：

```
    BCGenerator * generator = [[BCGenerator alloc]initWithWith:@"pseudorandom sequence"];
    // pseudorandom sequence 为你的随机数生成的结果

    NSLog(@"generator.rootPrivatekey = %@",generator.rootPrivatekey);
    NSLog(@"generator.mainProcessingKey = %@",generator.mainProcessingKey);
    NSLog(@"generator.rootPublickey = %@",generator.rootPublickey);
    NSLog(@"generator.address = %@",generator.address);

    BTCScript* outputScript = [[BTCScript alloc] initWithAddress:[BTCAddress addressWithString:generator.address]];
    NSLog(@"outputScript.data == %@",outputScript.data);
```

