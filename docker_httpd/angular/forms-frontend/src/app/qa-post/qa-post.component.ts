import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormQa } from '../form-qa';

@Component({
  selector: 'app-qa-post',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './qa-post.component.html',
  styleUrls: ['./qa-post.component.css']
})

export class QaPostComponent {

  readAnswer(answer: string){
    this.qpost.answer = answer
  }

  @Input() qpost!: FormQa
  @Output() newItemEvent = new EventEmitter<string>();

  addNewItem(value: string) {
    this.newItemEvent.emit(value);
  }


  console(){
    console.log("TEST")
  }
}
