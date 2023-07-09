import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddPollPostComponent } from './add-poll-post.component';

describe('AddPollPostComponent', () => {
  let component: AddPollPostComponent;
  let fixture: ComponentFixture<AddPollPostComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [AddPollPostComponent]
    });
    fixture = TestBed.createComponent(AddPollPostComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
