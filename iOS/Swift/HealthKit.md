
#[在Swift中使用HealthKit进行睡眠分析](http://www.appcoda.com/sleep-analysis-healthkit/)


作者：[Anushk Mittal](http://www.appcoda.com/author/anushkmittal/)

翻译：[feiyunhao](https://github.com/feiyunhao)

说明： 敢拿出来主要是让为了大家指点指点，哪些地方要改进。

----

如今，改善睡眠已成为一种时尚，人们比以往任何时候都更想知道自己的睡眠信息：不仅包括睡眠时间，更包括对周期性的数据分析后总结的睡眠规律。得益于硬件等技术的进步,特别是手机的飞速发展，让这个看似日益增长的领域获得了全新的曙光。

>

苹果公司提供了一个炫酷的方式来安全地处理用户的健康信息，并通过内置的健康应用安全地存储这些信息。HealthKit不仅可以用来来[打造一款健康应用](https://www.appcoda.com/healthkit-introduction/)，还可以对睡眠数据进行分析。

本教程中是一个HealthKit框架的快速入门，将会演示如何创建一个简单的睡眠分析应用。

##简介
HealthKit框架提供了一个结构体用来把数据保存到一个称作HealthKit仓库的加密数据库中；可以使用 HKHealthStore 类来访问该数据库。 iPhone和 Apple Watch都有自己独有的HealthKit仓库。用户的健康数据在iPhone和Apple Watch之间是同步的；但在Apple Watch中，旧的数据会周期性的清除以节省空间。在iPad中HealthKit和使用该框架的app不能正常工作。

HealthKit是一个创建iOS或者watchOS健康应用的强大的工具，它可以管理各种来源的数据，并根据用户的喜好自动合并不同来源的数据。应用程序可以访问每一数据来源的原始数据，并自动合并它们。这些数据不仅可以用于体型度量、健康或营养状况，也可以用于睡眠分析。

接下来的文章中，你将会了解到如何利用HealthKit框架存储和访问iOS睡眠分析数据。这些方法同样适用于watchOS应用。请注意，本教程基于Swift2.0和Xcode7。请确保你使用的是Xcode7及以上版本。

在正式开始之前，[请下载这个项目](https://github.com/appcoda/SleepAnalysis/blob/master/SleepAnalysisStarter.zip?raw=true)并压缩。我已经为你创建了包含基本功能的用户界面。运行这个工程，你将看到一个计时器界面，按下Start按钮之后开始计时。

##使用HealthKit Framework
我们这个应用的目的是使用Start和Stop按钮来记录和检索睡眠分析数据。首先，你需要现在工程里面授权，转到当前target -> capabilities来打开HealthKit权限。
<div align="center">    
<img src="http://www.appcoda.com/wp-content/uploads/2016/05/HealthKit-allow-1240x775.png"  width="620">
</div>

然后，你需要在ViewController类里用以下代码生成HKHealthStore实例

<pre><code>let healthStore = HKHealthStore()
</code></pre>

接着我们需要使用HKHealthStore实例来访问HealthKit仓库；

需要提及的一点是：HealthKit允许用户管理他们的健康数据，所以在你访问（读写）用户睡眠数据之前，你必须先请求用户授权。你需要引入HealthKit框架并重写ViewDidLoad方法：
<pre><code>override func viewDidLoad() {
    super.viewDidLoad()
    
    let typestoRead = Set([
        HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)!
        ])
    
    let typestoShare = Set([
        HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis)!
        ])
    
    self.healthStore.requestAuthorizationToShareTypes(typestoShare, readTypes: typestoRead) { (success, error) -> Void in
        if success == false {
            NSLog(" Display not allowed")
        }
    }
}
</code></pre>
这些代码将提示用户授权。在完成回调中，您可以处理授权成功或错误的情况、获得授权结果。用户不一定会授权你的应用程序的所有权限申请。你需要在程序中优雅地处理各种错误。
本示例程序中，为了实验你必须选择“允许”来授权应用程序访问你的设备上的健康数据。
<div align="center">   
<img src="http://www.appcoda.com/wp-content/uploads/2016/05/Health-App-Permission.png"  width="310">
</div>

##记录睡眠分析数据
首先，我们该如何检索睡眠分析数据？根据苹果官方文档，每个睡眠分析样本只能有一个值。为了区分用户躺在床上和已经睡着，HealthKit使用使用两个或多个重叠时间的样本。
通过比较这些样本的开始和结束时间，应用程序可以计算出一些统计数据：

* 用户经过多长时间才睡着
* 用户实际睡眠时间与在躺在床上时间的百分比
* 用户在床上时醒来的次数
* 实际睡眠时间和躺在床上的时间
<div align="center">    
<img src="http://www.appcoda.com/wp-content/uploads/2016/05/record_sleep_data.png"  width="545">
</div>
总之，你需要按照下面的方法把睡眠分析数据保存到HealthKit仓库：

1. 定义两个NSDate对象纪录的开始时间和结束时间；
2. 然后使用HKCategoryTypeIdentifierSleepAnalysis创建HKObjectType对象；
3. 创建HKCategorySample类型的对象。需要创建一个新的HKCategorySample类型对象。通常需要使用分类样本来记录睡眠数据。单个样品代表用户躺在床上或者已经睡着的时间段。因此，对相同的一段时间，我们需要创建一个代表躺在床上的样品和一个代表已经睡着的样本；
4. 最后，使用HKHealthStore中的saveObject的保存对象；

>编者注：样品的类型可以在这查看：[HealthKit Constants Reference](https://developer.apple.com/library/ios/documentation/HealthKit/Reference/HealthKit_Constants/index.html#//apple_ref/doc/uid/TP40014710)。

下面的代码可以正确保存用户躺在床上或者已经睡着的睡眠分析数据。请在ViewController类里写入这个方法
<pre><code>func saveSleepAnalysis() {
    
    // alarmTime and endTime are NSDate objects
    if let sleepType = HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis) {
        
        // we create our new object we want to push in Health app
        let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.InBed.rawValue, startDate: self.alarmTime, endDate: self.endTime)
        
        // at the end, we save it
        healthStore.saveObject(object, withCompletion: { (success, error) -> Void in
            
            if error != nil {
                // something happened
                return
            }
            
            if success {
                print("My new data was saved in HealthKit")
                
            } else {
                // something happened again
            }
            
        })
        
        
        let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.Asleep.rawValue, startDate: self.alarmTime, endDate: self.endTime)
        
        healthStore.saveObject(object2, withCompletion: { (success, error) -> Void in
            if error != nil {
                // something happened
                return
            }
            
            if success {
                print("My new data (2) was saved in HealthKit")
            } else {
                // something happened again
            }
            
        })
        
    }
    
}
</code></pre>
在需要把睡眠分析数据保存到HealthKit时调用这个函数。

##读取睡眠分析数据

我们需要创建一个查询来读取睡眠分析数据。你应该先为HKCategoryTypeIdentifierSleepAnalysis定义HKObjectType分类。可以使用一个谓词来通过对NSDate类型的startDate和endDate筛选相应时间范围内的数据。还需要创建一个sortDescriptor对获取的数据进行排序。

获取睡眠分析数据的代码应该像这样：
<pre><code>func retrieveSleepAnalysis() {
    
    // first, we define the object type we want
    if let sleepType = HKObjectType.categoryTypeForIdentifier(HKCategoryTypeIdentifierSleepAnalysis) {
        
        // Use a sortDescriptor to get the recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // we create our query with a block completion to execute
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            
            if error != nil {
                
                // something happened
                return
                
            }
            
            if let result = tmpResult {
                
                // do something with my data
                for item in result {
                    if let sample = item as? HKCategorySample {
                        let value = (sample.value == HKCategoryValueSleepAnalysis.InBed.rawValue) ? "InBed" : "Asleep"
                        print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                    }
                }
            }
        }
        
        // finally, we execute our query
        healthStore.executeQuery(query)
    }
}
</code></pre>
这段代码会查询所有睡眠分析数据并降序排列。然后打印出开始时间、结束时间以及对应状态（躺在床上或睡眠状态）。我这里设置的是检索过去30条的数据。你可以使用谓词的方法来设置自定义的开始和结束时间。

##应用测试

在示例程序中,我使用了一个计时器显示按下开始按钮之后经历的时间。按下开始和结束按钮时会创建NSDate对象来记录睡眠分析数据的时间间隔。在stop方法中,您可以调用saveSleepAnalysis()和retrieveSleepAnalysis()方法来保存和睡眠的数据。


<pre><code>@IBAction func stop(sender: AnyObject) {
    endTime = NSDate()
    saveSleepAnalysis()
    retrieveSleepAnalysis()
    timer.invalidate()
}
</code></pre>
在你的应用程序,您可能会更改NSDate对象选择相关的开始和结束时间(可能不同)来保存在床上以及睡着了的状态。
你做出了更改后,可运行程序并启动计时器。让它运行几分钟然后点击停止按钮。之后,打开健康应用，你会发现相应的睡眠数据。
<div align="center">   
<img src="http://www.appcoda.com/wp-content/uploads/2016/06/sleep-analysis-test-1240x878.png"  width="620">
</div>
##对使用HealthKit应用的一些建议
HealthKit旨在提供一个通用平台使开发者可以方便地分享和使用用户的数据，同时避免重复或不一致数据。苹果审核对于使用HealthKit和请求相应读/写权限非常严格，如果不明确地提醒用户可能会导致应用被拒。

保存虚假或不正确的数据的应用程序也会被拒。这意味着，你都不能天真地像本教程的睡眠分析那样，用自己的算法获得不同的结果。为避免使用错误数据，你读取和操作的任何参数都应该是来自内置的传感器数据。

完整的Xcode工程在[这里](https://github.com/appcoda/SleepAnalysis)。




