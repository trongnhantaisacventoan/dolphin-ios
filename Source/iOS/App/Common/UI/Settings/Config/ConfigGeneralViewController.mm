// Copyright 2022 DolphiniOS Project
// SPDX-License-Identifier: GPL-2.0-or-later

#import "ConfigGeneralViewController.h"

#import "Core/Config/MainSettings.h"

@interface ConfigGeneralViewController ()

@end

@implementation ConfigGeneralViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.dualCoreSwitch.on = Config::Get(Config::MAIN_CPU_THREAD);
  [self.dualCoreSwitch addValueChangedTarget:self action:@selector(dualCoreChanged)];
  
  self.cheatsSwitch.on = Config::Get(Config::MAIN_ENABLE_CHEATS);
  [self.cheatsSwitch addValueChangedTarget:self action:@selector(cheatsChanged)];
  
  self.mismatchedRegionSwitch.on = Config::Get(Config::MAIN_OVERRIDE_REGION_SETTINGS);
  [self.mismatchedRegionSwitch addValueChangedTarget:self action:@selector(mismatchedRegionChanged)];
  
  self.changeDiscsSwitch.on = Config::Get(Config::MAIN_AUTO_DISC_CHANGE);
  [self.changeDiscsSwitch addValueChangedTarget:self action:@selector(changeDiscsChanged)];
  
  int speedLimit = Config::Get(Config::MAIN_EMULATION_SPEED) * 100;
  
  if (speedLimit == 0) {
    self.speedLimitLabel.text = @"Unlimited";
  } else {
    self.speedLimitLabel.text = [NSString stringWithFormat:@"%d%%", speedLimit];
  }
}

- (void)dualCoreChanged {
  Config::SetBaseOrCurrent(Config::MAIN_CPU_THREAD, self.dualCoreSwitch.on);
}

- (void)cheatsChanged {
  Config::SetBaseOrCurrent(Config::MAIN_ENABLE_CHEATS, self.cheatsSwitch.on);
}

- (void)mismatchedRegionChanged {
  Config::SetBaseOrCurrent(Config::MAIN_OVERRIDE_REGION_SETTINGS, self.mismatchedRegionSwitch.on);
}

- (void)changeDiscsChanged {
  Config::SetBase(Config::MAIN_AUTO_DISC_CHANGE, self.changeDiscsSwitch.on);
}

@end
