require 'test_helper'

basic_tests('2014_march_firstlady_time_mixed',
            date: "3-4-2014",
            location: /Public Charter School/,
            start_time: "1:41 PM -0500",
            text_lines: [/How many people went to China/,
                         /My job is to listen now, okay/
                        ])
basic_tests('2014_fy2015_budget',
            date: '3-4-2014',
            location: /Elementary School/,
            start_time: "11:38 AM -0500",
            text_lines: [/because obviously the budget is not just about numbers/,
                         /by reforming our tax code and our immigration system/
                        ])

