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

class ChatroomViewController: MSGMessengerViewController {

          let bot = ChatUser(displayName: "AdminBot", avatar:#imageLiteral(resourceName: "baseline_person_black_24pt_1x"), avatarUrl: nil, isSender: false)
    
         let username:String = UserDefaults.standard.string(forKey: "username")!
          
         let owner = ChatUser(displayName: UserDefaults.standard.string(forKey: "username")!, avatar: #imageLiteral(resourceName: "outline_person_black_24pt_1x"), avatarUrl: nil, isSender: true)
          
            
          var id = 100
          
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
              
              let message = MSGMessage(id: id, body: body, user: owner, sentAt: Date())
              insert(message)
          }
          
          override func insert(_ message: MSGMessage) {
              
              collectionView.performBatchUpdates({
                  if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                      self.messages[self.messages.count - 1].append(message)
                      
                      let sectionIndex = self.messages.count - 1
                      let itemIndex = self.messages[sectionIndex].count - 1
                      self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                      
                  } else {
                      self.messages.append([message])
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
                          
                          let sectionIndex = self.messages.count - 1
                          let itemIndex = self.messages[sectionIndex].count - 1
                          self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                          
                      } else {
                          self.messages.append([message])
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
