<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>学生信息列表</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery & Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container py-4">
    <h1 class="text-center mb-4 text-primary">🎓 学生信息列表</h1>

    <!-- 搜索表单 -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/studentList">
                <div class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="studentId" placeholder="学号"
                               value="${param.studentId != null ? param.studentId : ''}">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="name" placeholder="姓名"
                               value="${param.name != null ? param.name : ''}">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="email" placeholder="邮箱"
                               value="${param.email != null ? param.email : ''}">
                    </div>
                    <div class="col-md-3 d-flex gap-2">
                        <button type="submit" class="btn btn-primary flex-grow-1">🔍 搜索</button>
                        <button type="button" class="btn btn-secondary" onclick="clearSearch()">↺ 重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- 添加按钮 -->
    <div class="d-flex justify-content-end mb-3">
        <a href="javascript:void(0);" class="btn btn-success" onclick="openAddModal()">
            ➕ 添加学生
        </a>
    </div>

    <!-- 构造基础 URL（带搜索参数） -->
    <c:url var="baseUrl" value="/studentList">
        <c:param name="studentId" value="${param.studentId}" />
        <c:param name="name" value="${param.name}" />
        <c:param name="email" value="${param.email}" />
        <c:param name="pageSize" value="${pageInfo.pageSize}" />
    </c:url>

    <!-- 无数据提示（根据 pageInfo 判断） -->
    <c:if test="${empty pageInfo.list}">
        <div class="alert alert-info text-center" role="alert">
            暂无学生数据。
        </div>
    </c:if>


    <!-- 学生表格（使用 pageInfo.list） -->
    <c:if test="${not empty pageInfo.list}">
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-primary">
                        <tr>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>出生日期</th>
                            <th>电话</th>
                            <th>邮箱</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" var="student">
                            <tr>
                                <td>${student.studentId}</td>
                                <td>${student.name}</td>
                                <td>${student.gender}</td>
                                <td>
                                    <c:if test="${not empty student.birthDate}">
                                        <fmt:formatDate value="${student.birthDate}" pattern="yyyy-MM-dd"/>
                                    </c:if>
                                </td>
                                <td>${student.phone}</td>
                                <td>${student.email}</td>
                                <td class="text-center">
                                    <a href="javascript:void(0)" class="btn btn-sm btn-outline-primary me-2"
                                       onclick="editStudent('${student.studentId}')">
                                        编辑
                                    </a>
                                    <a href="javascript:void(0)" class="btn btn-sm btn-outline-danger"
                                       onclick="deleteStudent('${student.studentId}')">
                                        删除
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ========== 分页导航（Bootstrap 5） ========== -->
        <c:if test="${pageInfo.pages > 1}">
            <nav aria-label="学生分页导航" class="mt-4">
                <ul class="pagination justify-content-center">

                    <!-- 首页 -->
                    <li class="page-item ${pageInfo.isFirstPage ? 'disabled' : ''}">
                        <a class="page-link" href="${baseUrl}&pageNum=1">首页</a>
                    </li>

                    <!-- 上一页 -->
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pageNum - 1}">«</a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasPreviousPage}">
                        <li class="page-item disabled">
                            <span class="page-link">«</span>
                        </li>
                    </c:if>

                    <!-- 页码 -->
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                        <c:choose>
                            <c:when test="${page == pageInfo.pageNum}">
                                <li class="page-item active" aria-current="page">
                                    <span class="page-link">${page}</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="${baseUrl}&pageNum=${page}">${page}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 下一页 -->
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pageNum + 1}">»</a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasNextPage}">
                        <li class="page-item disabled">
                            <span class="page-link">»</span>
                        </li>
                    </c:if>

                    <!-- 末页 -->
                    <li class="page-item ${pageInfo.isLastPage ? 'disabled' : ''}">
                        <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pages}">末页</a>
                    </li>

                </ul>
            </nav>

            <!-- 分页信息 -->
            <div class="text-center text-muted small">
                共 ${pageInfo.total} 条记录，每页 ${pageInfo.pageSize} 条，共 ${pageInfo.pages} 页
            </div>
        </c:if>
    </c:if>
</div>

<!-- ========== 新增学生模态框（自定义，非 Bootstrap Modal）========== -->
<div id="addModalOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1050; padding-top:80px;">
    <div style="background:white; margin:auto; width:90%; max-width:500px; border-radius:10px; padding:25px; position:relative;">
        <span style="position:absolute; top:15px; right:15px; font-size:24px; cursor:pointer;" onclick="closeModal()">&times;</span>
        <h2 class="text-center mb-4">➕ 新增学生信息</h2>
        <form id="addStudentForm" onsubmit="submitAddForm(event)">
            <div class="mb-3">
                <label for="studentId" class="form-label">学号 *</label>
                <input type="text" class="form-control" id="studentId" name="studentId" required>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">姓名 *</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="mb-3">
                <label for="gender" class="form-label">性别 *</label>
                <select class="form-select" id="gender" name="gender" required>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="birthDate" class="form-label">出生日期 *</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">电话</label>
                <input type="text" class="form-control" id="phone" name="phone">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">邮箱</label>
                <input type="email" class="form-control" id="email" name="email">
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success me-2">确定</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<!-- ========== 编辑学生模态框（Bootstrap Modal）========== -->
<div class="modal fade" id="editStudentModal" tabindex="-1" aria-labelledby="editStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editStudentModalLabel">编辑学生信息</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="edit-studentId">
                <div class="mb-3">
                    <label class="form-label">姓名</label>
                    <input type="text" class="form-control" id="edit-name" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">性别</label>
                    <select class="form-select" id="edit-gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">出生日期</label>
                    <input type="date" class="form-control" id="edit-birthDate">
                </div>
                <div class="mb-3">
                    <label class="form-label">电话</label>
                    <input type="text" class="form-control" id="edit-phone">
                </div>
                <div class="mb-3">
                    <label class="form-label">邮箱</label>
                    <input type="email" class="form-control" id="edit-email">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveEditBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<script>
    // === 以下 JS 逻辑完全保留不变 ===
    function openAddModal() {
        document.getElementById('addModalOverlay').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('addModalOverlay').style.display = 'none';
    }

    function deleteStudent(studentId) {
        if (!confirm('确定要删除该学生吗？')) return;
        fetch('${pageContext.request.contextPath}/studentDelete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: 'studentId=' + encodeURIComponent(studentId)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 删除成功');
                    location.reload();
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(error => {
                console.error('删除失败:', error);
                alert('网络错误，请重试');
            });
    }

    function submitAddForm(event) {
        event.preventDefault();
        const form = document.getElementById('addStudentForm');
        const formData = new FormData(form);
        fetch('${pageContext.request.contextPath}/studentAdd', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(formData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 学生信息添加成功！');
                    closeModal();
                    location.reload();
                } else {
                    alert('❌ 添加失败：' + (data.message || '未知错误'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('网络错误，请稍后重试');
            });
    }

    function editStudent(studentId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/getStudentInfoById",
            type: 'post',
            dataType: 'json',
            data: {
                studentId: studentId
            },
            success: function(data) {
                console.log(data)
                if (data) {
                    $('#edit-studentId').val(data.studentId);
                    $('#edit-name').val(data.name);
                    $('#edit-gender').val(data.gender || '男');

                    // 👇 关键：格式化日期
                    let birthDate = '';
                    if (data.birthDate) {
                        // 尝试解析各种可能的日期格式
                        const date = new Date(Number(data.birthDate));
                        // console.log(date);
                        // 格式化为 YYYY-MM-DD
                        const year = date.getFullYear();
                        // console.log(year);
                        const month = String(date.getMonth() + 1).padStart(2, '0'); // 月份从0开始
                        // console.log(month);
                        const day = String(date.getDate()).padStart(2, '0');
                        // console.log(day);
                        birthDate = year + '-' + month + '-' + day;
                        <%--birthDate = `${year}-${month}-${day}`;--%>
                        console.log(birthDate);

                    }
                    // console.log(birthDate);
                    $('#edit-birthDate').val(birthDate);
                    $('#edit-phone').val(data.phone);
                    $('#edit-email').val(data.email);

                    const modal = new bootstrap.Modal(document.getElementById('editStudentModal'));
                    modal.show();
                } else {
                    alert('未找到该学生信息！');
                }
            },
            error: function() {
                alert('获取学生信息失败，请重试。');
            }
        });
    }

    // 绑定“保存编辑”按钮事件（需在 DOM 加载后）
    $(document).ready(function() {
        $('#saveEditBtn').on('click', function() {
            const studentData = {
                studentId: $('#edit-studentId').val(),
                name: $('#edit-name').val(),
                gender: $('#edit-gender').val(),
                birthDate: $('#edit-birthDate').val(),
                phone: $('#edit-phone').val(),
                email: $('#edit-email').val()
            };

            if (!studentData.name.trim()) {
                alert('姓名不能为空！');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/studentUpdate',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(studentData),
                success: function(response) {
                    if (response.success) {
                        alert('保存成功！');
                        bootstrap.Modal.getInstance(document.getElementById('editStudentModal')).hide();
                        location.reload();
                    } else {
                        alert('保存失败：' + (response.message || '未知错误'));
                    }
                },
                error: function() {
                    alert('网络错误，请重试。');
                }
            });
        });
    });
    function clearSearch() {
        document.querySelector('input[name="studentId"]').value = '';
        document.querySelector('input[name="name"]').value = '';
        document.querySelector('input[name="email"]').value = '';
        document.getElementById('searchForm').submit(); // 或者跳转到无参页面
    }
</script>

</body>
</html>