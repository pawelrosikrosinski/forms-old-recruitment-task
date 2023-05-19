import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QaPostComponent } from './qa-post.component';

describe('QaPostComponent', () => {
  let component: QaPostComponent;
  let fixture: ComponentFixture<QaPostComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [QaPostComponent]
    });
    fixture = TestBed.createComponent(QaPostComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
