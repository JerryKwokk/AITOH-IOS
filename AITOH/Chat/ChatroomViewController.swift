//
//  ChatroomViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 31/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import MessengerKit
import Alamofire
import ApiAI
import SwiftyJSON

class ChatroomViewController: MSGMessengerViewController {

         let bot = ChatUser(displayName: "AdminBot", avatar:#imageLiteral(resourceName: "baseline_person_black_24pt_1x"), avatarUrl: nil, isSender: false)
    
         let username:String = UserDefaults.standard.string(forKey: "username")!
          
         let owner = ChatUser(displayName: UserDefaults.standard.string(forKey: "username")!, avatar: #imageLiteral(resourceName: "outline_person_black_24pt_1x"), avatarUrl: nil, isSender: true)
         
         var adminMessage:MSGMessage!
          var id = 100
          var adminRequest:Bool = false
          override var style: MSGMessengerStyle {
            var style = MessengerKit.Styles.iMessage
              style.headerHeight = 0
      //        style.inputPlaceholder = "Message"
      //        style.alwaysDisplayTails = true
      //        style.outgoingBubbleColor = .magenta
      //        style.outgoingTextColor = .black
      //        style.incomingBubbleColor = .green
      //        style.incomingTextColor = .yellow
      //        style.backgroundColor = .orange
      //        style.inputViewBackgroundColor = .purple
              return style
          }
          
          
          lazy var messages: [[MSGMessage]] = {
              return [
                  [
                      MSGMessage(id: 1, body: .text("Do you have any problem?"), user: bot, sentAt: Date()),
                  ],
              ]
          }()
          
          override func viewDidLoad() {
              super.viewDidLoad()
              
              title = "Help"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(btnClose))
            
            dataSource = self as MSGDataSource
            delegate = self as MSGDelegate
          }
    
        @objc func btnClose(){
            dismiss(animated: true, completion: nil)
        }
          
          override func viewDidAppear(_ animated: Bool) {
              super.viewDidAppear(animated)
              
              collectionView.scrollToBottom(animated: false)
          }
          
          override func inputViewPrimaryActionTriggered(inputView: MSGInputView) {
              id += 1
              
              let body: MSGMessageBody = (inputView.message.count < 5) ? .emoji(inputView.message) : .text(inputView.message)
              let text:String = inputView.message
            print(text)
            print(inputView.message)
            if(!adminRequest){
            let request = ApiAI.shared().textRequest()
              if text != "" {
                  print("request")
                  request?.query = text
              } else {
                  return
              }
            //發起請求並發送給機器人，處理API.AI回應的內容
      //程序返回成功訊息，應用程式說出回應並將其顯示在螢幕上，如果出現失敗訊息，那麼應用程式print錯誤到控制台
            
            var resText:String = ""
            
            
            
            

            let group = DispatchGroup()
            group.enter()

            DispatchQueue.main.async {
                            
                request?.setMappedCompletionBlockSuccess({ (request, response) in
                    let response = response as! AIResponse
                    if let textResponse = response.result.fulfillment.speech {
                        resText = textResponse
                        print("inside")
                        print(textResponse)
                        group.leave()
                    }
                }, failure: { (request, error) in
                    print(error!)
                })
                
                ApiAI.shared().enqueue(request)
                
            }

            // does not wait. But the code in notify() gets run
            // after enter() and leave() calls are balanced

            group.notify(queue: .main) {
                
                let adminBody: MSGMessageBody = .text(resText)
                self.adminMessage = MSGMessage(id: self.id, body: adminBody, user: self.bot, sentAt: Date())
                
                //self.messages[self.messages.count - 1].append(adminMessage)
                
                self.id+=1
                let message = MSGMessage(id: self.id, body: body, user: self.owner, sentAt: Date())
                print(resText)
                
                self.insert(message)
                if(resText == "OK, I was connecting the AITOH Administrator, please wait...."){
                    self.adminRequest = true
                }
            }
                
                
            }else{
                let message = MSGMessage(id: self.id, body: body, user: self.owner, sentAt: Date())
                self.insert(message)
                AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/chat")!, method: .post, parameters: ["userId":UserDefaults.standard.string(forKey: "userId")! ,"content": text], encoding: JSONEncoding.default).responseJSON { (response) in

                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
                
            }
            
            

             

          }
          
        override func insert(_ message: MSGMessage) {
              
              collectionView.performBatchUpdates({
                  if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                      self.messages[self.messages.count - 1].append(message)
                    if(!adminRequest){
                      self.messages[self.messages.count - 1].append(self.adminMessage)
                    }
                      let sectionIndex = self.messages.count - 1
                      let itemIndex = self.messages[sectionIndex].count - 1
                      self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                      
                  } else {
                      self.messages.append([message])
                    if(!adminRequest){
                      self.messages[self.messages.count - 1].append(self.adminMessage)
                    }
                    
                      let sectionIndex = self.messages.count - 1
                      self.collectionView.insertSections([sectionIndex])
                  }
              }, completion: { (_) in
                  self.collectionView.scrollToBottom(animated: true)
                  self.collectionView.layoutTypingLabelIfNeeded()
              })
              
          }
          
          override func insert(_ messages: [MSGMessage], callback: (() -> Void)? = nil) {
              
              collectionView.performBatchUpdates({
                  for message in messages {
                      if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                          self.messages[self.messages.count - 1].append(message)
                        if(!adminRequest){
                        self.messages[self.messages.count - 1].append(self.adminMessage)
                        }
                          let sectionIndex = self.messages.count - 1
                          let itemIndex = self.messages[sectionIndex].count - 1
                          self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                          
                      } else {
                          self.messages.append([message])
                        if(!adminRequest){
                          self.messages[self.messages.count - 1].append(self.adminMessage)
                        }
                          let sectionIndex = self.messages.count - 1
                          self.collectionView.insertSections([sectionIndex])
                      }
                  }
              }, completion: { (_) in
                  self.collectionView.scrollToBottom(animated: false)
                  self.collectionView.layoutTypingLabelIfNeeded()
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                      callback?()
            
                  }
              })
              
          }

      }

      // MARK: - Overrides
      extension ChatroomViewController {
          
      }

      // MARK: - MSGDataSource
      extension ChatroomViewController: MSGDataSource {
          
          func numberOfSections() -> Int {
              return messages.count
          }
          
          func numberOfMessages(in section: Int) -> Int {
              return messages[section].count
          }
          
          func message(for indexPath: IndexPath) -> MSGMessage {
              return messages[indexPath.section][indexPath.item]
          }
          
          func footerTitle(for section: Int) -> String? {
              return "Just now"
          }
          
          func headerTitle(for section: Int) -> String? {
              return messages[section].first?.user.displayName
          }

      }

      // MARK: - MSGDelegate
      extension ChatroomViewController: MSGDelegate {
          
          func linkTapped(url: URL) {
              print("Link tapped:", url)
          }
          
          func avatarTapped(for user: MSGUser) {
              print("Avatar tapped:", user)
          }
          
          func tapReceived(for message: MSGMessage) {
              print("Tapped: ", message)
          }
          
          func longPressReceieved(for message: MSGMessage) {
              print("Long press:", message)
          }
          
          func shouldDisplaySafari(for url: URL) -> Bool {
              return true
          }
          
          func shouldOpen(url: URL) -> Bool {
              return true
          }
          
      }
