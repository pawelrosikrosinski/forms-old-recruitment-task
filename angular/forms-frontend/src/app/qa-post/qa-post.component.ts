import { Component, Input } from '@angular/core';
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
  @Input() qpost!: FormQa
}
