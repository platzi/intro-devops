import { TestBed } from '@angular/core/testing';

import { JavatechieCovid19Service } from './javatechie-covid19.service';

describe('JavatechieCovid19Service', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: JavatechieCovid19Service = TestBed.get(JavatechieCovid19Service);
    expect(service).toBeTruthy();
  });
});
