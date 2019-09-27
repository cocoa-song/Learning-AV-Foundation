//
//  THViewController.swift
//  HelloAVF
//
//  Created by cocoa on 27/09/2019.
//  Copyright © 2019 kinemaster. All rights reserved.
//

import UIKit
import AVFoundation

class THViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    lazy var speechController = THSpeechController()
    var speechStrings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.constrainEqually(child: tableView, to: view)
        speechController.synthesizer.delegate = self
    }
}

extension THViewController: AVSpeechSynthesizerDelegate {
    
}

extension THViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        speechStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = speechStrings[indexPath.row]
        let speaker = Speaker(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: THBubbleCell.id) as! THBubbleCell
        cell.configure(speech: text, from: speaker)
        return cell
    }
}

enum Speaker {
    case machine
    case person
    
    init(indexPath: IndexPath) {
        self = indexPath.row % 2 == 0 ? .person : .machine
    }
}

class THBubbleCell: UITableViewCell {
    static let id = "THBubbleCell"
    private lazy var messageLabel: UILabel = {
      let label = UILabel()
        return label
    }()
    
    func configure(speech text: String, from speaker: Speaker) {
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.constrainEqually(child: messageLabel, to: contentView)
        messageLabel.text = text
        switch speaker {
        case .machine:
            contentView.backgroundColor = .blue
        case .person:
            contentView.backgroundColor = .green
        }
    }
}

class THSpeechController: NSObject {
    let synthesizer = AVSpeechSynthesizer()
    
    func beginConversation() {
        
    }
}


extension NSLayoutConstraint {
    static func constrainEqually(child: UIView, to parent: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: parent.topAnchor),
            child.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            child.leftAnchor.constraint(equalTo: parent.leftAnchor),
            child.rightAnchor.constraint(equalTo: parent.rightAnchor),
        ])
    }
}
