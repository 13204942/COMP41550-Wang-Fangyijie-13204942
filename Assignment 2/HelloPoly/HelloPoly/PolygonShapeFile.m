//
//  PolygonShape.m
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PolygonShapeFile.h"

//
//  PolygonShape.m
//  HelloPoly
//
//  Created by CSI COMP41550 on 03/01/2012.
//  Copyright (c) 2012 UCD. All rights reserved.
//



@implementation PolygonShape

#define MAX_SIDES 12
static const int MIN_SIDES = 3;


- (id)init {
    return [self initWithNumberOfSides:3];
}

- (id)initWithNumberOfSides:(int)sides
{
    if (!(self = [super init]))
    {
        return nil;
    }
    self.numberOfSides = sides;
    return self;
}

- (void)setNumberOfSides:(NSUInteger)numberOfSides
{
    if (numberOfSides > MAX_SIDES) {
        NSLog(@"Invalid number of sides: %d is greater than the maximum of %d allowed", numberOfSides, MAX_SIDES);
        return;
    }
    if(numberOfSides < MIN_SIDES) {
        NSLog(@"Invalid number of sides: %d is smaller than the minimum of %d allowed", numberOfSides, MIN_SIDES);
        return;
    }
    _numberOfSides = numberOfSides;
}

- (NSArray *)pointsForPolygonInRect:(CGRect)rect {
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / self.numberOfSides;
    //float exteriorAngle = M_PI - angle;
    //float rotationDelta = angle - (0.5 * exteriorAngle);
    
    for (int currentAngle = 0; currentAngle < self.numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle - M_PI_2);
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        //float newAngle = (angle * currentAngle) - rotationDelta;
        //float curX = cos(newAngle) * radius;
        //float curY = cos(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:
                           CGPointMake(center.x + curX, center.y + curY)]];
    }
    return [result copy];
}


- (NSString *)name
{
    NSArray *names = @[@"Triangle",
                       @"Square",
                       @"Pentagon",
                       @"Hexagon",
                       @"Heptagon",
                       @"Octagon",
                       @"Nonagon",
                       @"Decagon",
                       @"Hendecagon",
                       @"Dodecagon"];
    
    return names[self.numberOfSides-MIN_SIDES];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Hello I am a %d-sided polygon (aka a %@).", self.numberOfSides, self.name];
}

@end