import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PollQUestion } from '../poll-question';
import { FormsModule } from '@angular/forms';
import { MatRadioModule } from '@angular/material/radio';
import {MatInputModule} from '@angular/material/input';


@Component({
  selector: 'app-add-poll-post',
  standalone: true,
  imports: [CommonModule, FormsModule, MatRadioModule, MatInputModule],
  templateUrl: './add-poll-post.component.html',
  styleUrls: ['./add-poll-post.component.css']
})
export class AddPollPostComponent {

  @Input() pollquestion!: PollQUestion;

  answer!:Text

}
