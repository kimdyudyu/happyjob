package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.common.comnUtils.FileUtilModel;
import kr.happy.jobkorea.hla.dao.LecDao;
import kr.happy.jobkorea.hla.model.LecListModel;

@Service
public class LecServiceImpl implements LecService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();

	
	@Autowired
	LecDao lecturerDao;
	
	@Override
	public List<LecListModel> lectList(Map<String, Object> paramMap) {
		System.out.println("임플확인1");
		 List<LecListModel> lectList = lecturerDao.lectList(paramMap);
		 System.out.println("임플확인2");
		return lectList;
	}

	@Override
	public List<LecListModel> lectPeopleInfo(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인1");
		 List<LecListModel> lectPeopleInfo = lecturerDao.lectPeopleInfo(paramMap);
		 System.out.println("임플확인2");
		return lectPeopleInfo;
	}

	@Override
	public List<Map<String, Object>> studentCnsInfo(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인1 (학생상담이력");
		List<Map<String, Object>> studentCnsInfo = lecturerDao.studentCnsInfo(paramMap);
		System.out.println("임플확인2 ( 학생상담이력)");
		return studentCnsInfo;
	}

	@Override
	public List<Map<String, Object>> cnsDetail(Map<String, Object> paramMap) throws Exception {
		
		System.out.println("임플확인1 (학생상담내용");
		List<Map<String, Object>> cnsDetail = lecturerDao.cnsDetail(paramMap);
		System.out.println("임플확인2 ( 학생상담내용)");
		
		return cnsDetail;
	}

	@Override
	public int updateCns(Map<String, Object> paramMap) throws Exception {
		 int updateCns = lecturerDao.updateCns(paramMap);
		return updateCns;
	}

	@Override
	public void insertCns(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인 상담내용 신규 등록");
		lecturerDao.insertCns(paramMap);
		
	}


/*	@Override
	public List<LecListModel> classtListAct(Map<String, Object> paramMap) throws Exception {
		System.out.println("임플확인1");
		 List<LecListModel> classtListAct = lecturerDao.classtListAct(paramMap);
		 System.out.println("임플확인2");
		return classtListAct;
	}

	@Override
	public int applyForClass(Map<String, Object> paramMap) throws Exception {
		int ret = 0;
		try {	
				ret = lecturerDao.applyForClass(paramMap); 
		} catch(Exception e) {
			throw e;
		}
		return ret;
	}
*/
}
