const String wholeBody = "전신";
const String legs = "하체";
const String back = "등";
const String chest = "가슴";
const String shoulders = "어깨";
const String biceps = "이두";
const String triceps = "삼두";
const String core = "코어";
const String foreArms = "전완";

const Map<String, Map<String, dynamic>> workouts = {
  "스미스 머신 벤치 프레스": {
    "target": [wholeBody],
    "imgSrc": "chest/smith-machine-bench-press",
  },
  "데드리프트": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/deadlift",
  },
  "바벨 클린 앤 프레스": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/barbell-clean-and-press",
  },
  "바벨 행 클린": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/barbell-hang-clean",
  },
  "바벨 행 스네치": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/barbell-hang-snatch",
  },
  "바벨 파워 클린": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/barbell-power-clean",
  },
  "클린 앤 저크": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/clean-and-jerk",
  },
  "바벨 루마니안 데드리프트": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/dumbbell-romanian-deadlift",
  },
  "랙 풀": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/rack-pull",
  },
  "루마니안 데드리프트": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/romanian-deadlift",
  },
  "스모 데드리프트": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/sumo-deadlift",
  },
  "트랩 바 데드리프트": {
    "target": [wholeBody],
    "imgSrc": "wholeBody/trap-bar-deadlift",
  },
  "스쿼트": {
    "target": [legs],
    "imgSrc": "legs/squat",
  },
  "덤벨 불가리안 스플릿 스쿼트": {
    "target": [legs],
    "imgSrc": "legs/dumbbell-bulgarian-split-squat",
  },
  "프론트 스쿼트": {
    "target": [legs],
    "imgSrc": "legs/front-squat",
  },
  "고블릿 스쿼트": {
    "target": [legs],
    "imgSrc": "legs/goblet-squat",
  },
  "핵 스쿼트": {
    "target": [legs],
    "imgSrc": "legs/hack-squat",
  },
  "힙 쓰러스트": {
    "target": [legs],
    "imgSrc": "legs/hip-thrust",
  },
  "레그 익스텐션": {
    "target": [legs],
    "imgSrc": "legs/leg-extension",
  },
  "레그 프레스": {
    "target": [legs],
    "imgSrc": "legs/leg-press",
  },
  "라잉 레그 컬": {
    "target": [legs],
    "imgSrc": "legs/lying-leg-curl",
  },
  "머신 카프 레이즈": {
    "target": [legs],
    "imgSrc": "legs/machine-calf-raise",
  },
  "시티드 레그 컬": {
    "target": [legs],
    "imgSrc": "legs/seated-leg-curl",
  },
  "시티드 레그 프레스": {
    "target": [legs],
    "imgSrc": "legs/seated-leg-press",
  },
  "바벨 슈러그": {
    "target": [back],
    "imgSrc": "back/barbell-shrug",
  },
  "벤트 오버 로우": {
    "target": [back],
    "imgSrc": "back/bent-over-row",
  },
  "친 업": {
    "target": [back],
    "imgSrc": "back/chin-ups",
  },
  "덤벨 풀오버": {
    "target": [back],
    "imgSrc": "back/dumbbell-pullover",
  },
  "덤벨 로우": {
    "target": [back],
    "imgSrc": "back/dumbbell-row",
  },
  "덤벨 슈러그": {
    "target": [back],
    "imgSrc": "back/dumbbell-shrug",
  },
  "랫 풀 다운": {
    "target": [back],
    "imgSrc": "back/lat-pulldown",
  },
  "시티드 로우 머신": {
    "target": [back],
    "imgSrc": "back/seated-row-machine",
  },
  "펜들레이 로우": {
    "target": [back],
    "imgSrc": "back/pendlay-row",
  },
  "풀 업": {
    "target": [back],
    "imgSrc": "back/pull-ups",
  },
  "시티드 케이블 로우": {
    "target": [back],
    "imgSrc": "back/seated-cable-row",
  },
  "티 바 로우": {
    "target": [back],
    "imgSrc": "back/t-bar-row",
  },
  "벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/bench-press",
  },
  "케이블 플라이": {
    "target": [chest],
    "imgSrc": "chest/cable-fly",
  },
  "체스트 프레스": {
    "target": [chest],
    "imgSrc": "chest/chest-press",
  },
  "클로즈 그립 벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/close-grip-bench-press",
  },
  "디클라인 벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/decline-bench-press",
  },
  "덤벨 벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/dumbbell-bench-press",
  },
  "덤벨 플라이": {
    "target": [chest],
    "imgSrc": "chest/dumbbell-fly",
  },
  "인클라인 벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/incline-bench-press",
  },
  "인클라인 덤벨 벤치 프레스": {
    "target": [chest],
    "imgSrc": "chest/incline-dumbbell-bench-press",
  },
  "머신 체스트 플라이": {
    "target": [chest],
    "imgSrc": "chest/machine-chest-fly",
  },
  "푸쉬업": {
    "target": [chest],
    "imgSrc": "chest/push-ups",
  },
  "아놀드 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/arnold-press",
  },
  "케이블 레터럴 레이즈": {
    "target": [shoulders],
    "imgSrc": "shoulders/cable-lateral-raise",
  },
  "덤벨 프론트 레이즈": {
    "target": [shoulders],
    "imgSrc": "shoulders/dumbbell-front-raise",
  },
  "덤벨 레터럴 레이즈": {
    "target": [shoulders],
    "imgSrc": "shoulders/dumbbell-lateral-raise",
  },
  "덤벨 숄더 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/dumbbell-shoulder-press",
  },
  "숄더 프레스 머신": {
    "target": [shoulders],
    "imgSrc": "shoulders/machine-shoulder-press",
  },
  "밀리터리 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/military-press",
  },
  "푸쉬 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/push-press",
  },
  "시티드 덤벨 숄더 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/seated-dumbbell-shoulder-press",
  },
  "시티드 숄더 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/seated-shoulder-press",
  },
  "숄더 프레스": {
    "target": [shoulders],
    "imgSrc": "shoulders/shoulder-press",
  },
  "업라이트 로우": {
    "target": [shoulders],
    "imgSrc": "shoulders/upright-row",
  },
  "바벨 컬": {
    "target": [biceps],
    "imgSrc": "biceps/barbell-curl",
  },
  "케이블 바이셉 컬": {
    "target": [biceps],
    "imgSrc": "biceps/cable-bicep-curl",
  },
  "컨센트레이션 컬": {
    "target": [biceps],
    "imgSrc": "biceps/concentration-curl",
  },
  "덤벨 컬": {
    "target": [biceps],
    "imgSrc": "biceps/dumbbell-curl",
  },
  "이지바 바이셉 컬": {
    "target": [biceps],
    "imgSrc": "biceps/ez-bar-curl",
  },
  "해머 컬": {
    "target": [biceps],
    "imgSrc": "biceps/hammer-curl",
  },
  "인클라인 덤벨 컬": {
    "target": [biceps],
    "imgSrc": "biceps/incline-dumbbell-curl",
  },
  "바이셉 컬 머신": {
    "target": [biceps],
    "imgSrc": "biceps/machine-bicep-curl",
  },
  "원 암 케이블 바이셉 컬": {
    "target": [biceps],
    "imgSrc": "biceps/one-arm-cable-bicep-curl",
  },
  "원 암 덤벨 프리쳐 컬": {
    "target": [biceps],
    "imgSrc": "biceps/one-arm-dumbbell-preacher-curl",
  },
  "프리쳐 컬": {
    "target": [biceps],
    "imgSrc": "biceps/preacher-curl",
  },
  "케이블 오버헤드 트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/cable-overhead-tricep-extension",
  },
  "딥스": {
    "target": [triceps],
    "imgSrc": "triceps/dips",
  },
  "덤벨 트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/dumbbell-tricep-extension",
  },
  "덤벨 트라이셉 킥백": {
    "target": [triceps],
    "imgSrc": "triceps/dumbbell-tricep-kickback",
  },
  "라잉 덤벨 트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/lying-dumbbell-tricep-extension",
  },
  "라잉 트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/lying-tricep-extension",
  },
  "트라이셉 익스텐션 머신": {
    "target": [triceps],
    "imgSrc": "triceps/machine-tricep-extension",
  },
  "시티드 딥스 머신": {
    "target": [triceps],
    "imgSrc": "triceps/seated-dip-machine",
  },
  "시티드 덤벨 트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/seated-dumbbell-tricep-extension",
  },
  "트라이셉 익스텐션": {
    "target": [triceps],
    "imgSrc": "triceps/tricep-extension",
  },
  "트라이셉 푸쉬다운": {
    "target": [triceps],
    "imgSrc": "triceps/tricep-pushdown",
  },
  "트라이셉 로프 푸쉬다운": {
    "target": [triceps],
    "imgSrc": "triceps/tricep-rope-pushdown",
  },
  "AB 롤아웃": {
    "target": [core],
    "imgSrc": "core/ab-wheel-rollout",
  },
  "케이블 크런치": {
    "target": [core],
    "imgSrc": "core/cable-crunch",
  },
  "케이블 우드 쵸퍼": {
    "target": [core],
    "imgSrc": "core/cable-woodchopper",
  },
  "크런치": {
    "target": [core],
    "imgSrc": "core/crunches",
  },
  "디클라인 싯 업": {
    "target": [core],
    "imgSrc": "core/decline-sit-up",
  },
  "덤벨 사이드 벤드": {
    "target": [core],
    "imgSrc": "core/dumbbell-side-bend",
  },
  "행잉 니 레이즈": {
    "target": [core],
    "imgSrc": "core/hanging-knee-raise",
  },
  "행잉 레그 레이즈": {
    "target": [core],
    "imgSrc": "core/hanging-leg-raise",
  },
  "라잉 레그 레이즈": {
    "target": [core],
    "imgSrc": "core/lying-leg-raise",
  },
  "시티드 크런치 머신": {
    "target": [core],
    "imgSrc": "core/machine-seated-crunch",
  },
  "러시안 트위스트": {
    "target": [core],
    "imgSrc": "core/russian-twist",
  },
  "싯 업": {
    "target": [core],
    "imgSrc": "core/sit-ups",
  },
  "덤벨 리버스 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/dumbbell-reverse-curl",
  },
  "덤벨 리버스 리스트 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/dumbbell-reverse-wrist-curl",
  },
  "덤벨 리스트 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/dumbbell-wrist-curl",
  },
  "리버스 바벨 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/reverse-barbell-curl",
  },
  "리버스 리스트 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/reverse-wrist-curl",
  },
  "리스트 컬": {
    "target": [foreArms],
    "imgSrc": "foreArms/wrist-curl",
  },
};
