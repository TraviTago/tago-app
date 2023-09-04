enum ReportType { TRAVEL_MATE_ISSUE, TAXI_DRIVER_ISSUE, PLAN_ISSUE, OTHERS }

class ReportModel {
  static final Map<ReportType, String> reportTypeMap = {
    ReportType.TRAVEL_MATE_ISSUE: "여행메이트와 불편한 문제가 생겼어요",
    ReportType.TAXI_DRIVER_ISSUE: "택시기사님이 불친절해요",
    ReportType.PLAN_ISSUE: "기존의 계획된 코스로 진행되지 않아요",
    ReportType.OTHERS: "기타문의",
  };
}
