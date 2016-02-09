//
//  Categorise.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/13/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation

func categorise<S : SequenceType, U : Hashable>(
    seq: S,
    @noescape keyFunc: S.Generator.Element -> U
    ) -> [U:[S.Generator.Element]]
{
    var dict: [U:[S.Generator.Element]] = [:]
    for el in seq {
        let key = keyFunc(el)
        dict[key] = (dict[key] ?? []) + [el]
    }
    return dict
}